module main

import os

fn main() {
	file_path := 'sample_text_file.txt'
	/*
	if os.is_file(file_path) {
		println('file already exists, exiting...')
		return
	}

	if !os.exists(file_path) {
		println('ERROR: file ${file_path} not found!')
		return
	}
	*/

	mut f := os.create(file_path) or {
		println('file is not writable')
		return
	}

	f.writeln('Hola desde V') or { panic(err) }
	f.writeln('') or { panic(err) }
	f.writeln('The standard Lorem Ipsum passage, used since the 1500s') or { panic(err) }
	f.writeln('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.') or {
		panic(err)
	}
	f.writeln('Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.') or {
		panic(err)
	}

	f.close()
}
