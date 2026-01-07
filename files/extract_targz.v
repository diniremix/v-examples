// https://modules.vlang.io/archive.tar.html
// https://github.com/vlang/v/blob/master/examples/archive/tar_gz_reader.v
import os
import archive.tar

struct FileReader implements tar.Reader {
mut:
	content_file os.File
	filepath     string
}

fn (f FileReader) other_block(read &tar.Read, details string) {
	println('OTHER: ${read.get_path()} (${details})')
}

fn (r FileReader) dir_block(read &tar.Read, size u64) {
	path := read.get_path()
	os.mkdir_all(path) or { eprintln('directory: "${read.get_path()}" cannot be created') }
}

fn (mut r FileReader) file_block(read &tar.Read, size u64) {
	path := read.get_path()
	println('path: ${path} size: ${size}')

	file := os.create(path) or {
		eprintln('cannot create "${path}": ${err}')
		return
	}
	r.content_file = file
	r.filepath = path
}

fn (mut r FileReader) data_block(read &tar.Read, data []u8, pending int) {
	path := read.get_path()
	if r.filepath != path {
		return
	}

	r.content_file.write(data) or {
		eprintln('error writing file: "${path}": ${err}')
		r.content_file.close()
		return
	}

	if pending == 0 {
		// our file of interest data is complete
		r.content_file.close()
		// println('${path}')
		r.filepath = ''
		// read.stop_early = true //?
	}
}

fn main() {
	// https://github.com/vlang/v/archive/refs/tags/v0.1.3.tar.gz
	path := 'v-0.1.3.tar.gz'

	data := os.read_bytes(path) or {
		eprintln(err)
		return
	}

	mut extractor := FileReader{}

	mut untar := tar.new_untar(extractor)
	mut decompressor := tar.new_decompressor(untar)

	decompressor.read_all(data)!
}
