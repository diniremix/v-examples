module main

import encoding.binary
import os

struct Person {
	name      string
	age       int
	interests []string //@[serialize: '-'] // this field will be skipped
}

fn main() {
	file_path := 'person.bin'

	p := Person{
		name:      'Peter'
		age:       456
		interests: [
			'music',
			'books',
			'programming',
		]
	}
	println('person info to save:')
	println(p)
	println('')

	bytes_data := binary.encode_binary(p)!
	// guardar bytes al archivo
	os.write_bytes(file_path, bytes_data) or { panic(err) }

	// Leer bytes del archivo
	loaded_bytes := os.read_bytes(file_path) or { panic(err) }
	mut bin_data := binary.decode_binary[Person](loaded_bytes)!

	read_person := Person{
		name:      bin_data.name
		age:       bin_data.age
		interests: bin_data.interests
	}

	println('read data from "${file_path}"')
	println(read_person) // Person{name: 'Peter' age: 456 interests: ['music', 'books', 'programming']}
}
