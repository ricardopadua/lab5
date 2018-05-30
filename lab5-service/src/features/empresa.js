const knex = require("../db").knex
const router = require("express").Router()

router.get("/list", (req,res) => 
knex("empresa").select().then(ret => res.send(ret)))

router.post("/save", (req,res) => 
knex("empresa",).insert(req.body,"idempresa").then(ret => res.send("ok:", +ret)))

router.put("/save", (req,res) => 
knex("empresa").update(req.body).where("idempresa",req.body.idempresa).then(ret => res.send("ok:" +ret)))

router["delete"]("/:idempresa", (req,res) => 
knex ("empresa").del().where("idempresa", req.params.idempresa).then(ret => res.send("ok:" +ret)))

exports.router = router