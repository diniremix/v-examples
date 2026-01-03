/*
ejemplo de conexion y uso de MySQL en V
- con la feature `fpool` utiliza un pool de conexiones
	`v mysql_orm.v -d fpool -o mysql_orm`
- utiliza el ORM de V
- utiliza modelos `@[table: 'table_name']` del ORM
- carga variables de entorno con `zztkm.vdotenv`
*/
module main

import db.mysql
import pool
import os
import zztkm.vdotenv

$if fpool ? {
	import time
}

@[table: 'wp_term_taxonomy']
struct Taxonomy {
	term_taxonomy_id int    @[primary; sql: serial]
	term_id          int    @[sql: u64]
	taxonomy         string @[sql_type: 'VARCHAR(32)']
	description      string @[sql_type: 'LONGTEXT']
	parent           int    @[sql: u64]
	count            int    @[sql: u64]
}

fn get_db_conn() !&mysql.Config {
	if os.getenv_opt('MYSQL_CLUSTER') == none || os.getenv_opt('MYSQL_USERNAME') == none
		|| os.getenv_opt('MYSQL_DB') == none {
		panic('missing env vars for MYSQL connection')
		// os.exit(1)
	}
	db_conn := mysql.Config{
		host:     os.getenv_opt('MYSQL_CLUSTER') or { 'localhost' }
		port:     os.getenv_opt('MYSQL_PORT') or { '3306' }.u32()
		username: os.getenv_opt('MYSQL_USERNAME') or { 'awesome_user' }
		password: os.getenv_opt('MYSQL_PASS') or { 'awesome_pass' }
		dbname:   os.getenv_opt('MYSQL_DB') or { 'awesome_db' }
	}
	return &db_conn
}

// Configure pool parameters
$if fpool ? {
	fn create_pool_config() !&pool.ConnectionPoolConfig {
		config := pool.ConnectionPoolConfig{
			max_conns:      20
			min_idle_conns: 1
			max_lifetime:   1 * time.hour
			idle_timeout:   30 * time.second // time.minute
			get_timeout:    5 * time.second
		}
		return &config
	}

	// Define your connection factory function
	fn create_pool_conn() !&pool.ConnectionPoolable {
		db_conn := get_db_conn()!
		db := mysql.connect(db_conn)!
		return &db
	}
}

fn main() {
	vdotenv.load()

	// usando un pool de conexiones
	$if fpool ? {
		println('usando la feature fpool')
		config := create_pool_config()!
		// Create connection pool
		mut my_pool := pool.new_connection_pool(create_pool_conn, config)!
		defer {
			// When application exits
			my_pool.close()
		}

		// Acquire connection
		mut conn := my_pool.get()!
		defer {
			// Return connection to pool
			my_pool.put(conn) or { eprintln(err) }
		}

		// Convert `conn` to a `mysql.DB` object
		mut db := conn as mysql.DB

		assert db.validate()!
		// Do a query
		// select from Taxonomy where term_taxonomy_id == 1
		parent := sql db {
			select from Taxonomy
		}!
		println(parent)
	} $else {
		println('sin features')
		// normal conn
		config := get_db_conn()!
		// Connect to server
		mut db := mysql.connect(config)!
		defer {
			// When application exits
			db.close() or { eprintln('cannot connect to DB in no fature mode') }
		}
		// Do a query
		// select from Taxonomy where term_taxonomy_id == 1
		parent := sql db {
			select from Taxonomy
		}!
		println(parent)
	} // conditional compile time
}
