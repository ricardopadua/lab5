// Update with your config settings.

module.exports = {

  development: {
    client: 'postgres',
    connection: {
<<<<<<< HEAD
        host: '192.168.0.158',
	database: 'lab5_dev',
	user: 'postgres',
	password: 'bitnami'
=======
      host: '192.168.11.3',
	database: 'lab5_dev',
	user: 'postgres',
	password: '******'
>>>>>>> 8bee194d69972d1adf8a518a89749648d653fe72
    }
  },

  staging: {
    client: 'postgresql',
    connection: {
      database: 'my_db',
      user:     'username',
      password: 'password'
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  },

  production: {
    client: 'postgresql',
    connection: {
      database: 'my_db',
      user:     'username',
      password: 'password'
    },
    pool: {
      min: 2,
      max: 10
    },
    migrations: {
      tableName: 'knex_migrations'
    }
  }

};
