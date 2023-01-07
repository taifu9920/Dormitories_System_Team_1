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
    req.session.loc = req.baseUrl + req.path;
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
            DB.query("SELECT M_ID, Name, Password FROM dormitories_system.managers;", function (err, rows) {
                if (err) reject(process.env["DB_connect_failed"])
                else {
                    datas = new Map(rows.map(o => [o.M_ID, [o.Password, o.Name]]));
                    resolve(datas)
                }
            })
        })
        //Student Account Check
        Student = await new Promise((resolve, reject) => {
            DB.query("SELECT S_ID, Name, Password FROM dormitories_system.students;", function (err, rows) {
                if (err) reject(process.env["DB_connect_failed"])
                else {
                    datas = new Map(rows.map(o => [o.S_ID, [o.Password, o.Name]]));
                    resolve(datas)
                }
            })
        })
        if ((req.session.username == System.get("owner_account")
            && req.session.password == System.get("owner_password"))
            || (Manager.get(req.session.username) && Manager.get(req.session.username)[0] == req.session.password
                && req.session.password != null)
            || (Student.get(req.session.username) && Student.get(req.session.username)[0] == req.session.password
                && req.session.password != null)) {
            if (req.session.username == System.get("owner_account")) {
                req.session.level = 0;
                req.session.name = "總務處";
            }
            else if (Manager.get(req.session.username)) {
                req.session.level = 1;
                req.session.name = Manager.get(req.session.username)[1];
            }
            else if (Student.get(req.session.username)) {
                req.session.level = 2;
                req.session.name = Student.get(req.session.username)[1];
            }
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

/*學生瀏覽公告&留言板*/
app.get("/", csurf({ cookie: true }), auth, async function (req, res) {
    req.session.loc = req.baseUrl + req.path;
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });

    comments = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.comments order by `When` DESC limit 100', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    Announcement = await new Promise((resolve, reject) => {
        DB.query('select `Value` from dormitories_system.configs where `SC_Tag` = "Announcement"', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    Rules = await new Promise((resolve, reject) => {
        DB.query('select `Value` from dormitories_system.configs where `SC_Tag` = "Rules"', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });


    dormitories = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.dormitories', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    register = await new Promise((resolve, reject) => {
        DB.query('select b.*,a.D_ID,a.R_ID,d.Name , c.costs from dormitories_system.registers as b join dormitories_system.students as a on a.S_ID = b.S_ID natural left outer join dormitories_system.rooms as c left outer join dormitories_system.dormitories as d on c.D_ID = d.D_ID where a.S_ID = ?', [req.session.username], function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    res.render("home", {
        username: req.session.username, name: req.session.name,
        level: level_names[req.session.level],
        comments: comments, Announcement: Announcement[0].Value, Rules: Rules[0].Value, csrfToken: req.csrfToken(),
        registers: register, dormitories: dormitories,
        msg: cookie, route: req.baseUrl + req.path
    });
});

app.get("/manage", csurf({ cookie: true }), auth, async function (req, res) {
    req.session.loc = req.baseUrl + req.path;
    let cookie = req.cookies["msg"];
    res.clearCookie("msg", { httpOnly: true });

    if (req.session.level == 0) {
        managers = await new Promise((resolve, reject) => {
            DB.query('select * from dormitories_system.managers', function (err, rows) {
                if (err) reject(err);
                resolve(rows);
            });
        }).catch(() => { });
    } else managers = undefined

    students = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.students;', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    dormitories = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.dormitories', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    rooms = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.rooms', function (err, rows) {
            if (err) reject(err);
            datas = new Map();
            for (i = 0; i < rows.length; i++) {
                if (datas.has(rows[i].D_ID)) datas.get(rows[i].D_ID).push([rows[i].R_ID, rows[i].Peoples, rows[i].Costs, []]);
                else datas.set(rows[i].D_ID, [[rows[i].R_ID, rows[i].Peoples, rows[i].Costs, []]]);
            }
            resolve(datas);
        });
    }).catch(() => { });

    tmp = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.rooms natural join dormitories_system.students', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });
    for (i = 0; i < tmp.length; i++) {
        room = rooms.get(tmp[i].D_ID)
        for (o = 0; o < room.length; o++) {
            if (room[o][0] == tmp[i].R_ID) {
                room[o][3].push(tmp[i])
                break;
            }
        }
    }

    permissions = await new Promise((resolve, reject) => {
        DB.query('SELECT * FROM dormitories_system.permissions;', function (err, rows) {
            if (err) reject(err);
            datas = new Map();
            for (i = 0; i < rows.length; i++) {
                if (datas.has(rows[i].D_ID)) datas.get(rows[i].D_ID).push(rows[i].M_ID);
                else datas.set(rows[i].D_ID, [rows[i].M_ID]);
            }
            resolve(datas);
        });
    }).catch(() => { });

    room_contents = await new Promise((resolve, reject) => {
        DB.query('select * from `dormitories_system`.`room_contents` as `A` join `dormitories_system`.`rooms` as `B` on `B`.`D_ID` = `A`.`D_ID` and `B`.`R_ID` = `A`.`R_ID`', function (err, rows) {
            if (err) reject(err);
            else {
                datas = new Map();
                for (i = 0; i < rows.length; i++) {
                    data = rows[i];
                    if (datas.has(data.D_ID)) {
                        RoomData = datas.get(data.D_ID)
                        if (!RoomData.has(data.R_ID)) RoomData.set(data.R_ID, [])
                        RoomData.get(data.R_ID).push([data.RC_ID, data.Name, data.Amount])
                    }
                    else {
                        datas.set(data.D_ID, new Map())
                        datas.get(data.D_ID).set(data.R_ID, [[data.RC_ID, data.Name, data.Amount]])
                    }
                }
                resolve(datas);
            }
        });
    }).catch(() => { });

    registers = await new Promise((resolve, reject) => {
        DB.query('select b.*,a.D_ID,a.R_ID,d.Name, e.Name as req_Name , c.costs from dormitories_system.registers as b join dormitories_system.students as a on a.S_ID = b.S_ID natural left outer join dormitories_system.rooms as c left outer join dormitories_system.dormitories as d on c.D_ID = d.D_ID left outer join dormitories_system.dormitories as e on b.req_D_ID = e.D_ID ', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    Announcement = await new Promise((resolve, reject) => {
        DB.query('select `Value` from dormitories_system.configs where `SC_Tag` = "Announcement"', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    violations = await new Promise((resolve, reject) => {
        DB.query('select * from dormitories_system.violation_records', function (err, rows) {
            if (err) reject(err);
            resolve(rows);
        });
    }).catch(() => { });

    if (req.session.level == 1 || req.session.level == 0) res.render("manage", {
        username: req.session.username, name: req.session.name,
        level: level_names[req.session.level], managers: managers,
        students: students, Announcement: Announcement[0].Value, permissions: permissions, violations: violations,
        dormitories: dormitories, rooms: rooms, room_contents: room_contents, registers: registers,
        csrfToken: req.csrfToken(), msg: cookie, route: req.baseUrl + req.path
    });
    else res.redirect("/");
});


// -- Authed Posts --
app.post("/manage", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var M_ID = req.body.M_ID;
    var Name = req.body.Name;
    var Email = req.body.Email;
    var Phone = req.body.Phone;
    var Password = req.body.Password;
    var sql = 'INSERT INTO dormitories_system.managers (M_ID, Name, Email, Phone, Password) VALUES (?,?,?,?,?)';

    res.cookie("msg", "新增成功。", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [M_ID, Name, Email, Phone, Password], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch(err => {
        console.log(err);
        res.cookie("msg", "新增失敗！請重試。", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/anno", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/"
    res.cookie("msg", "更新公告成功。", { httpOnly: true });
    var sql = 'UPDATE `dormitories_system`.`configs` SET `Value` = ? WHERE (`SC_Tag` = "announcement")';
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.Announcement], function (err, data) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch(() => {
        res.cookie("msg", "更新失敗！請重試。", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/comm", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/"
    var sql = 'INSERT INTO dormitories_system.comments (`S_ID`, `Content`) VALUES (?,?)';
    res.cookie("msg", "新增留言成功。", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.session.username, req.body.Content], function (err) {
            if (err) { reject(err); console.log(err); }
            else { resolve(); }
        });
    }).catch(err => {
        console.log(err);
        res.cookie("msg", "新增留言失敗！請重試。", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/rules", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/"
    var sql = 'UPDATE `dormitories_system`.`configs` SET `Value` = ? WHERE (`SC_Tag` = "Rules")';
    res.cookie("msg", "更新住宿須知成功。", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.rules], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch(() => {
        res.cookie("msg", "更新失敗！請重試。", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/register", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/"
    var sql = 'INSERT INTO dormitories_system.registers (`S_ID`, `req_D_ID`, `Year`, `Term`, `Approved`, `Payment`) VALUES (?,?,?,?,?,?)';
    res.cookie("msg", "住宿申請成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.session.username, req.body.D_ID, 111, 1, 1, 0], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "申請失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/pay", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/"
    var sql = 'UPDATE `dormitories_system`.`registers` SET `Payment` = ? WHERE (`S_ID` = ?)';
    res.cookie("msg", "付款成功", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.pay, req.session.username], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "付款失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/ManagerUpdate", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'UPDATE `dormitories_system`.`managers` SET `M_ID` = ?, `Name` = ?, `Email` = ?, `Phone` = ?, `Password` = ? WHERE (`M_ID` = ?)';
    res.cookie("msg", "更新成功", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.OriginalM_ID, req.body.Name, req.body.Email, req.body.Phone, req.body.Password, req.body.M_ID], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "更新失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/delete", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = (req.body.commentID ? "/" : "/manage")
    res.cookie("msg", "刪除成功", { httpOnly: true });
    inputs = []
    sql = ""
    if (req.body.commentID) {
        sql = "DELETE FROM `dormitories_system`.`comments` WHERE (`C_ID` = ?);";
        inputs = [req.body.commentID]
    } else if (req.body.M_ID) {
        sql = "DELETE FROM `dormitories_system`.`managers` WHERE (`M_ID` = ?);";
        inputs = [req.body.M_ID]
    } else if (req.body.RC_ID) {
        sql = "DELETE FROM `dormitories_system`.`room_contents` WHERE (`RC_ID` = ?);";
        inputs = [req.body.RC_ID]
    } else if (req.body.D_ID) {
        if (req.body.R_ID) {
            sql = "DELETE FROM `dormitories_system`.`rooms` WHERE (`D_ID` = ?) and (`R_ID` = ?);";
            inputs = [req.body.D_ID, req.body.R_ID]
        } else {
            sql = "DELETE FROM `dormitories_system`.`dormitories` WHERE (`D_ID` = ?);";
            inputs = [req.body.D_ID]
        }
    } else if (req.body.Reg_ID) {
        success = true;
        await new Promise((resolve, reject) => {
            DB.query("UPDATE `dormitories_system`.`students` SET `D_ID` = NULL, `R_ID` = NULL WHERE (`S_ID` = ?);", [req.body.S_ID], function (err) {
                if (err) reject(err);
                else { resolve(); }
            });
        }).catch((err) => {
            console.log(err);
            success = false;
            res.cookie("msg", "刪除失敗，請重試", { httpOnly: true });
        });
        if (success) {
            sql = "DELETE FROM `dormitories_system`.`registers` WHERE (`Reg_ID` = ?);"
            inputs = [req.body.Reg_ID]
        }
    } else if (req.body.S_ID) {
        sql = "DELETE FROM `dormitories_system`.`students` WHERE (`S_ID` = ?)";
        inputs = [req.body.S_ID]
    } else if (req.body.V_ID) {
        sql = "DELETE FROM `dormitories_system`.`violation_records` WHERE (`V_ID` = ?)";
        inputs = [req.body.V_ID]
    }
    if (sql != "" || inputs != []) {
        await new Promise((resolve, reject) => {
            DB.query(sql, inputs, function (err) {
                if (err) reject(err);
                else { resolve(); }
            });
        }).catch((err) => {
            console.log(err);
            res.cookie("msg", "刪除失敗，請重試", { httpOnly: true });
        });
    }
    res.redirect(req.session.loc);
});


app.post("/addRoomContent", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'INSERT INTO dormitories_system.room_contents (`D_ID`, `R_ID`, `Name`, `Amount`) VALUES (?,?,?,?)';
    res.cookie("msg", "設備新增成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.D_ID, req.body.R_ID, req.body.Name, req.body.Amount], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "設備新增失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/roomUpdate", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'UPDATE `dormitories_system`.`rooms` SET `D_ID` = ?, `R_ID` = ?, `Peoples` = ?, `Costs` = ? WHERE (`D_ID` = ?) and (`R_ID` = ?)';
    res.cookie("msg", "房間資訊更新成功", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.new_D_ID, req.body.new_R_ID, req.body.Peoples, req.body.Costs, req.body.D_ID, req.body.R_ID], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "房間資訊更新失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});


app.post("/updateRoomContent", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'UPDATE `dormitories_system`.`room_contents` SET `Name` = ?, `Amount` = ? WHERE (`RC_ID` = ?)';
    res.cookie("msg", "房間設備更新成功", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.Name, req.body.Amount, req.body.RC_ID], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "房間設備更新失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});


app.post("/newDorm", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'INSERT INTO dormitories_system.dormitories (`Name`) VALUES (?)';
    res.cookie("msg", "設備新增成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.Name], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "設備新增失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/renameDorm", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'UPDATE `dormitories_system`.`dormitories` SET `Name` = ? WHERE (`D_ID` = ?)';
    res.cookie("msg", "宿舍改名成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.Name, req.body.D_ID], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "宿舍改名失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/addRoom", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'INSERT INTO dormitories_system.rooms (`D_ID`, `R_ID`,`Peoples`, `Costs`) VALUES (?, ?, ?, ?)';
    res.cookie("msg", "房間新增成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.D_ID, req.body.R_ID, req.body.Peoples, req.body.Costs], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "房間新增失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/updatePerm", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    sql = 'DELETE FROM `dormitories_system`.`permissions` WHERE (`D_ID` = ?);';
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.D_ID], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
    });
    if (!Array.isArray(req.body.M_ID)) req.body.M_ID = [req.body.M_ID];
    sql = 'INSERT INTO `dormitories_system`.`permissions` (`D_ID`, `M_ID`) VALUES (?, ?)';
    for (i = 0; i < req.body.M_ID.length; i++) {
        await new Promise((resolve, reject) => {
            DB.query(sql, [req.body.D_ID, req.body.M_ID[i]], function (err) {
                if (err) reject(err);
                else { resolve(); }
            });
        }).catch((err) => {
            console.log(err);
        });
    }
    res.cookie("msg", "權限更新成功！", { httpOnly: true });
    res.redirect(req.session.loc);
});

app.post("/StudentUpdate", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'UPDATE `dormitories_system`.`students` SET `S_ID` = ?, `Name` = ?, `Year` = ?, `Dept_Name` = ?, `Email` = ?, `Phone` = ?, `Sex` = ?, `D_ID` = ?, `R_ID` = ?, `Password` = ? WHERE (`S_ID` = ?)';
    res.cookie("msg", "學生資訊更新成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.S_ID, req.body.Name, req.body.Year, req.body.Dept_Name, req.body.Email, req.body.Phone, req.body.Sex, req.body.D_ID, req.body.R_ID, req.body.Password, req.body.OriginalS_ID], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "學生資訊更新失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/addStudent", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'INSERT INTO dormitories_system.students (`S_ID`, `Name`, `Year`, `Dept_Name`, `Email`, `Phone`, `Sex`, `D_ID`, `R_ID`, `Password`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';
    res.cookie("msg", "學生新增成功！", { httpOnly: true });
    req.body.D_ID = (req.body.D_ID == "null" ? null : req.body.D_ID)
    req.body.R_ID = (req.body.R_ID == "null" ? null : req.body.R_ID)
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.S_ID, req.body.Name, req.body.Year, req.body.Dept_Name, req.body.Email, req.body.Phone, req.body.Sex, req.body.D_ID, req.body.R_ID, req.body.Password], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "學生新增失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/addViolations", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'INSERT INTO `dormitories_system`.`violation_records` (`S_ID`, `Content`) VALUES (?,?)';
    res.cookie("msg", "違規登記成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.S_ID, req.body.Content], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "違規登記失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.post("/updateViolation", express.urlencoded({ extended: false }), csurf({ cookie: true }), auth, async function (req, res) {
    if (req.session.loc == undefined) req.session.loc = "/manage"
    var sql = 'UPDATE `dormitories_system`.`violation_records` SET `S_ID` = ?, `Content` = ?, `When` = ? WHERE (`V_ID` = ?)';
    res.cookie("msg", "紀錄更新成功！", { httpOnly: true });
    await new Promise((resolve, reject) => {
        DB.query(sql, [req.body.S_ID, req.body.Content, req.body.When, req.body.V_ID], function (err) {
            if (err) reject(err);
            else { resolve(); }
        });
    }).catch((err) => {
        console.log(err);
        res.cookie("msg", "紀錄更新失敗，請重試", { httpOnly: true });
    });
    res.redirect(req.session.loc);
});

app.use((req, res) => {
    res.status(404).send("Request 404");
})

app.listen(process.env["port"], process.env["ip"], () => {
    logger.info(`Server is listening on port number: ${process.env["port"]}`);
});