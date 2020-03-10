var config = {
	development: {
			  user: 'ccg18fdu', // env var: PGUSER
			  database: 'ccg18fdu', // env var: PGDATABASE
			  password: 'Coopster123', // env var: PGPASSWORD
			  host: 'cmpstudb-01.cmp.uea.ac.uk', // Server hosting the postgres database
			  port: 5432, // env var: PGPORT
			  max: 10, // max number of clients in the pool
			  idleTimeoutMillis: 30000 // how long a client is allowed to remain idle before being closed
	},
	production: {
			  user: 'ccg18fdu', // env var: PGUSER
			  database: 'ccg18fdu', // env var: PGDATABASE
			  password: 'Coopster123', // env var: PGPASSWORD
			  host: 'cmpstudb-01.cmp.uea.ac.uk', // Server hosting the postgres database
			  port: 5432, // env var: PGPORT
			  max: 10, // max number of clients in the pool
			  idleTimeoutMillis: 30000 // how long a client is allowed to remain idle before being closed
	},
	
};
module.exports = config;