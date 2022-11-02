require('dotenv').config();
require('winston-daily-rotate-file')
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
    if (req.body["account"] == process.env["account"] && req.body["password"] == process.env["password"]) {
        req.session.username = process.env["account"];
        res.redirect("/");
    }
    else {
        res.cookie("msg", "Wrong information", { httpOnly: true });
        res.redirect("/signin");
    }
});

app.get("/logout", function(req, res) {
    req.session.destroy();
    res.cookie("msg", "You have been logout.", { httpOnly: true });
    res.redirect('/signin');
});

// After login
function auth(req, res, next){
    if (req.session.username == process.env["account"]) next()
    else return res.redirect('/signin')
}

app.get("/", auth, function(req, res) {
    res.render("home", { msg: "Hello user: " + req.session.username });
});

app.use((req, res) => {
    res.status(404).send("Request 404");
})

app.listen(process.env["port"], process.env["ip"], () => {
    logger.info(`Server is listening on port number: ${process.env["port"]}`);
});