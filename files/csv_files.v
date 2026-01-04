module main

import encoding.csv
import os

fn read_cells(mut csvr csv.RandomAccessReader) {
	// The data will be saved in this array
	mut data := [][]string{len: csvr.csv_map.len}

	for row_index in 1 .. csvr.csv_map.len {
		// get single cells from file
		// Index,Customer Id,First Name,Last Name,Company,City,Country,Phone 1,Phone 2,Email,Subscription Date,Website
		data[row_index] << csvr.get_cell(x: 0, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 1, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 2, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 3, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 4, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 5, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 6, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 7, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 8, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 9, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 10, y: row_index) or { break }
		data[row_index] << csvr.get_cell(x: 11, y: row_index) or { break }
		// println(data[row_index])
	}
}

fn read_row(mut csvr csv.RandomAccessReader) {
	// get each row from file
	for row_index in 1 .. csvr.csv_map.len {
		row := csvr.get_row(row_index) or { break }
		println(row)
	}
}

fn main() {
	file_path := 'customers-100000.csv'

	if !os.exists(file_path) {
		println('ERROR: file ${file_path} not found!')
		return
	}

	mut csvr := csv.csv_reader(
		file_path:    file_path                     // path to the file CSV
		mem_buf_size: 1024 * 1024 * 5               // we set X MByte of buffer for this file
		end_line_len: csv.endline_crlf_len // we are using a windows text file
	)!

	read_row(mut csvr)
	read_cells(mut csvr)
	csvr.dispose_csv_reader()
}
