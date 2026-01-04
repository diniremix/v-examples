module main

import os

fn main() {
	file_path := 'customers-100000.csv'

	if !os.exists(file_path) {
		println('ERROR: file ${file_path} not found!')
		return
	}

	// Leer el archivo completo
	contents := os.read_file(file_path) or { panic(err) }
	println(contents)

	println('')
	println('=========')
	println('')

	// Leer línea por línea
	lines := os.read_lines(file_path) or { panic(err) }
	for line in lines {
		println(line)
	}

	println('')
	println('=========')
	println('')

	line_split := contents.split_into_lines()
	for line in line_split {
		println(line)
	}
}
