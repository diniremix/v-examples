// https://modules.vlang.io/archive.tar.html
import os
import archive.tar

struct ListReader implements tar.Reader {
}

// is called when untar reads a block of type directory.
fn (r ListReader) dir_block(dir &tar.Read, size u64) {
	println('${dir.get_path()} -> size: ${size} bytes')
}

// is called when untar reads a block of type filename.
fn (r ListReader) file_block(file &tar.Read, size u64) {
	println('${file.get_path()} -> size: ${size} bytes')
}

// is called when untar reads a block of type filedata.
fn (r ListReader) data_block(read &tar.Read, data []u8, pending int) {
	// TODO
}

// is called when untar reads a block type other than directory
fn (r ListReader) other_block(read &tar.Read, details string) {
	println('OTHER: ${read.get_path()} (${details})')
}

fn main() {
	// https://github.com/vlang/v/archive/refs/tags/v0.1.3.tar.gz
	path := 'v-0.1.3.tar.gz'

	if !os.exists(path) {
		eprintln('no such file: ${path}')
		return
	}

	// debug example
	// mut reader := tar.DebugReader{}
	mut reader := ListReader{}

	tar.read_tar_gz_file(path, reader) or { eprintln(err) }
}
