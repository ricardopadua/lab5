// src/main.js
const knex = require("./db.js").knex
const express = require ("express")
const bodyParser = require ("body-parser")
const morgan = require("morgan")
const app = express ()

app.use(morgan("dev"))
app.use(bodyParser.json())

// Additional middleware which will set headers that we need on each request.
app.use((req, res, next) => {
    // Set permissive CORS header - this allows this server to be used only as
    // an API server in conjunction with something like webpack-dev-server.
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "X-Filename, Content-Type");
    res.setHeader("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");

    // Disable caching so we'll always get the latest comments.
    res.setHeader('Cache-Control', 'no-cache');
    next();
});



app.use("/empresa", require("./features/empresa").router)

app.get("/online",(req, res) => res.send("ONLINE"))

exports.start = porta =>
knex.migrate.latest().then( _ => app.listen(porta))
