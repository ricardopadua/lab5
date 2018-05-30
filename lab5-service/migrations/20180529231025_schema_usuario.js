exports.up = knex => knex.schema.createTable("usuario", tb => {
  	tb.increments("idusuario")
  	tb.string("nomeusuario")
	tb.timestamp("datanascusuario").notNullable().defaultTo(knex.fn.now())
	})

exports.down = knex => knex.schema
        .dropTable("usuario")
