require('dotenv').config();
require('winston-daily-rotate-file')
// setup

level_names = ["管理員", "舍監", "學生"]

const express = require("express")
    , winston = require('winston')
    , { combine, timestamp, printf, colorize, align } = winston.format
    , expressWinston = require('express-winston')
    , csurf = require('csurf')
    , cookieParser = require('cookie-parser')
    , compression = require('compression')
    , session = require('express-session');

// logger init
let logger = winston.createLogger({
    level: process.env.LOG_LEVEL || 'info'
    , format: combine(
        colorize({ all: true })
        , timestamp({ format: 'YYYY-MM-DD hh:mm:ss.SSS A' })
        , align()
        , printf((info) => `[${info.timestamp}] ${info.level}: ${info.message}`)
    )
    , transports: [new winston.transports.Console()
        , new winston.transports.DailyRotateFile({
            filename: './logs/%DATE%.log'
            , datePattern: 'YYYY-MM-DD'
            , maxFiles: '31d'
        })
    ]
    ,
});

// DB connection init
var mysql = require("mysql");
var DB = mysql.createConnection({
    host: process.env["DB_IP"],
    user: process.env["DB_User"],
    port: process.env["DB_Port"],
    password: process.env["DB_Pass"],
    database: process.env["DB_Schema"]
});

DB.connect(function (err) {
    if (err) logger.error(process.env["DB_connect_failed"]);
    else logger.info(process.env["DB_connect_success"]);
});

// Web init
let app = express();

app.use(compression())
app.engine('ejs', require("ejs-locals"))
app.set('view engine', 'ejs');

app.use(session({
    secret: process.env["session_secret"],
    saveUninitialized: false,
    resave: true,
}));

// Setup logger with web
app.use(expressWinston.logger({
    transports: [new winston.transports.Console()]
    , format: combine(
        colorize({ all: true })
        , timestamp({ format: 'YYYY-MM-DD hh:mm:ss.SSS A' })
        , align()
        , printf((info) => `[${info.timestamp}] ${info.level}: ${info.message}`)
    )
    , meta: true
    , msg: "{{req.socket.remoteAddress}} ({{req.headers['x-forwarded-for']}}) - {{res.statusCode}} {{req.method}} {{res.responseTime}}ms {{req.url}}"
    , expressFormat: false
    , ignoreRoute: function (req, res) { return false; }
}));

// Routes
app.use("/", express.static("static"));

app.use(cookieParser());

// -- Before Login --

app.get("/signin", csurf({ cookie: true }), function (req, res) {
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });
    res.render("index", { csrfToken: req.csrfToken(), msg: cookie });
});

app.post("/login", express.urlencoded({ extended: false }), csurf({ cookie: true }), function (req, res) {
    req.session.username = req.body["account"];
    req.session.password = req.body["password"];
    res.redirect("/");
});

app.get("/logout", function (req, res) {
    req.session.destroy();
    res.cookie("msg", "您已登出，請重新登入！", { httpOnly: true });
    res.redirect('/signin');
});

// -- After login --
async function auth(req, res, next) {
    try {
        //System Account Check
        System = await new Promise((resolve, reject) => {
            DB.query("SELECT * FROM dormitories_system.configs where `SC_Tag` like 'owner_%';", function (err, rows) {
                if (err) reject(process.env["DB_connect_failed"])
                else {
                    datas = new Map(rows.map(o => [o.SC_Tag, o.Value]));
                    resolve(datas)
                }
            })
        })
        //Manager Account Check
        Manager = await new Promise((resolve, reject) => {
            DB.query("SELECT M_ID, Password FROM dormitories_system.managers;", function (err, rows) {
                if (err) reject(process.env["DB_connect_failed"])
                else {
                    datas = new Map(rows.map(o => [o.M_ID, o.Password]));
                    resolve(datas)
                }
            })
        })
        //Student Account Check
        Student = await new Promise((resolve, reject) => {
            DB.query("SELECT S_ID, Password FROM dormitories_system.students;", function (err, rows) {
                if (err) reject(process.env["DB_connect_failed"])
                else {
                    datas = new Map(rows.map(o => [o.S_ID, o.Password]));
                    resolve(datas)
                }
            })
        })
        if ((req.session.username == System.get("owner_account")
            && req.session.password == System.get("owner_password"))
            || (Manager.get(req.session.username) == req.session.password
                && req.session.password != null)
            || (Student.get(req.session.username) == req.session.password
                && req.session.password != null)) {
            if (req.session.username == System.get("owner_account")) req.session.level = 0
            else if (Manager.get(req.session.username)) req.session.level = 1
            else if (Student.get(req.session.username)) req.session.level = 2
            next()
        }
        else {
            res.cookie("msg", "登入失敗！請重試。", { httpOnly: true });
            res.redirect("/signin");
        }
    } catch (e) {
        logger.error("Error when auth a user, Error message: " + e);
        req.session.destroy();
        res.cookie("msg", "出錯誤了!\n如無法登入聯繫伺服器管理人員！", { httpOnly: true });
        res.redirect("/signin");
    }
}

app.get("/", auth, function (req, res) {
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });
    res.render("home", { username: req.session.username, level: level_names[req.session.level], msg: cookie, route: req.baseUrl + req.path });
});

app.get("/lodge", auth, function (req, res) {
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });
    if (req.session.level == 2) res.render("lodge", { username: req.session.username, level: level_names[req.session.level], msg: cookie, route: req.baseUrl + req.path });
    else res.redirect("/");
});

app.get("/manage", csurf({ cookie: true }), auth, async function (req, res) {
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });

    managers = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.managers', function (err, rows, fields) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(err => { });

    students = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.students', function (err, rows, fields) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(err => { });

    comments = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.comments', function (err, rows, fields) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(err => { });

    configs = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.configs', function (err, rows, fields) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(err => { });
    if (req.session.level == 1 || req.session.level == 0) res.render("manage", { username: req.session.username, level: level_names[req.session.level], managers: managers, students: students, comments: comments, configs: configs, csrfToken: req.csrfToken(), msg: cookie, route: req.baseUrl + req.path });
    else res.redirect("/");
});

app.post("/manage", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    var M_ID = req.body.M_ID;
    var Name = req.body.Name;
    var Email = req.body.Email;
    var Phone = req.body.Phone;
    var Password = req.body.Password;
    var sql = 'INSERT INTO dormitories_system.managers (M_ID, Name, Email, Phone, Password) VALUES (?,?,?,?,?)';

    res.cookie("msg", "新增成功。", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [M_ID, Name, Email, Phone, Password], function (err, data) {
            if (err) reject(err);
            else {
                resolve();
            }
        });
    }).catch(err => {
        res.cookie("msg", "新增失敗！請重試。", { httpOnly: true });
    });
    res.redirect('/manage');
});

app.get("/anno", csurf({ cookie: true }), auth, function (req, res) {
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });
    res.render("manage", {
        comments: comments,
        configs: configs,
        csrfToken: req.csrfToken(),
        msg: cookie
    });
});
app.post("/anno", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    res.cookie("msg", "更新公告成功。", { httpOnly: true });
    var anno = req.body.Announcement;
    var sql = 'UPDATE `dormitories_system`.`configs` SET `Value` = ? WHERE (`SC_Tag` = "announcement")';
    await new Promise((resolve, reject) => {
        DB.query(sql, [anno], function (err, data) {
            if (err) reject(err);
            else {
                resolve();
            }
        });
    }).catch(err => {
        res.cookie("msg", "更新失敗！請重試。", { httpOnly: true });
    });
    res.redirect('/manage');
});

app.use((req, res) => {
    res.status(404).send("Request 404");
})

app.listen(process.env["port"], process.env["ip"], () => {
    logger.info(`Server is listening on port number: ${process.env["port"]}`);
});