// src/main.js
const knex = require("./db.js").knex
const express = require ("express")
const bodyParser = require ("body-parser")
const morgan = require("morgan")
const app = express ()

app.use(morgan("dev"))
app.use(bodyParser.json())

<<<<<<< HEAD
app.use("/empresa", require("./features/empresa").router)
=======
app.get("/online",(req, res) => res.send("ONLINE"))
>>>>>>> 8bee194d69972d1adf8a518a89749648d653fe72

exports.start = porta =>
knex.migrate.latest().then( _ => app.listen(porta))
