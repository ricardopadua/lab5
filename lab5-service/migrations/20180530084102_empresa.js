exports.up = knex => knex.schema.createTable ("empresa",tb => {
tb.increments("idempresa")
tb.string("razaosocial")
tb.string("nomefantasia")
tb.string("cnpj")
tb.timestamp("dataabertura").notNullable().defaultTo(knex.fn.now())

})

exports.down = knex => knex.schema.dropTable("empresa") 



