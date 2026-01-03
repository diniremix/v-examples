// este ejemplo utiliza el módulo `sqlite`
// `v install sqlite`
module main

// import db.sqlite
import sqlite

fn main() {
	println('conectando...')
	mut db := sqlite.connect('v_sample_db.db')!
	defer { db.close() or {} }

	println('creando tabla...')
	db.exec("create table if not exists users (id integer primary key, name text default '');") or {
		panic(err)
	}

	println('insertando registros...')
	db.exec("insert into users (name) values ('Sam')")!
	db.exec("insert into users (name) values ('Peter')")!
	db.exec("insert into users (name) values ('Kate')")!

	println('validando...')
	nr_users := db.q_int('select count(*) from users')!
	println('nr users = ${nr_users}')

	println('consultando...')
	name := db.q_string('select name from users where id = 1')!
	assert name == 'Sam'

	println('consultando todos...')
	users := db.exec('select * from users')!
	for row in users {
		println(row.vals)
	}
	println('saliendo...')
	// db.close() or {}
}
