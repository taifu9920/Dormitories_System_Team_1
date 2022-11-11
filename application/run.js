require('dotenv').config();
require('winston-daily-rotate-file')
var mysql = require("mysql");
var DB = mysql.createConnection({
    host: process.env["DB_IP"],
    user: process.env["DB_User"],
    port: process.env["DB_Port"],
    password: process.env["DB_Pass"],
    database: process.env["DB_Schema"]
});

const express = require("express")
    , winston = require('winston')
    , { combine, timestamp, printf, colorize, align } = winston.format
    , expressWinston = require('express-winston')
    , csurf = require('csurf')
    , cookieParser = require('cookie-parser')
    , compression = require('compression')
    , session = require('express-session');

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
, });

DB.connect(function(err) {
    if (err) logger.error(process.env["DB_connect_failed"]);
    else logger.info(process.env["DB_connect_success"]);
});

let app = express();
app.use(compression())
app.set('view engine', 'ejs');


app.use(session({
    secret: process.env["session_secret"],
    saveUninitialized: false,
    resave: true, 
}));

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
    , ignoreRoute: function(req, res) { return false; }
}));

app.use("/", express.static("static"));

app.use(cookieParser());

// Before Login

app.get("/signin", csurf({ cookie: true }), function(req, res) {
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });
    res.render("index", { csrfToken: req.csrfToken(), "msg": cookie });
});

app.post("/login", express.urlencoded({ extended: false }), csurf({ cookie: true }), function(req, res) {
    var datas = DB.query("SELECT * FROM dormitories_system.configs;", function(err, rows){
        if (err) logger.error(process.env["DB_connect_failed"]);
        else{
            datas = new Map(rows.map(o => [o.SC_Tag, o.Value]));
            if (req.body["account"] == datas.get("owner_account") && req.body["password"] == datas.get("owner_password")) {
                req.session.username = req.body["account"];
                res.redirect("/");
            } else {
                res.cookie("msg", "Login failed!", { httpOnly: true });
                res.redirect("/signin");
            }
        }
    })
});

app.get("/logout", function(req, res) {
    req.session.destroy();
    res.cookie("msg", "您已登出，請重新登入！", { httpOnly: true });
    res.redirect('/signin');
});

// After login
function auth(req, res, next){
    DB.query("SELECT * FROM dormitories_system.configs;", function(err, rows){
        if (err) logger.error(process.env["DB_connect_failed"]);
        else {
            datas = new Map(rows.map(o => [o.SC_Tag, o.Value]));
            if (req.session.username == datas.get("owner_account")) next()
            else return res.redirect('/signin')
        }
    })
}

app.get("/", auth, function(req, res) {
    res.render("home", { username: req.session.username});
});

app.get("/lodge", auth, function(req, res) {
    res.render("lodge", { username: req.session.username});
});

app.get("/manage", auth, function(req, res) {
    res.render("manage", { username: req.session.username});
});

app.use((req, res) => {
    res.status(404).send("Request 404");
})

app.listen(process.env["port"], process.env["ip"], () => {
    logger.info(`Server is listening on port number: ${process.env["port"]}`);
});