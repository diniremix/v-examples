module main

import db.mysql

fn main() {
	config := mysql.Config{
		host:     'localhost'
		port:     3306
		username: 'awesome_username'
		password: 'awesome_pass'
		dbname:   'awesome_db'
	}
	// Create connection
	// Connect to server
	mut db := mysql.connect(config)!
	defer {
		// When application exits
		db.close() or {}
	}
	// Do a query
	res := db.query('select * from awesome_table_name')!
	rows := res.rows()

	for row in rows {
		println(row.vals)
	}

	// Close the connection if needed
	// db.close() or {}
}
