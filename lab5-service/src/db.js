// src/db.js
const cfg = require("../knexfile")
const knex = require("knex")(cfg.development)
exports.knex = knex
