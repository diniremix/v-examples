module main

import term

fn main() {
	term.clear()
	println('tablas de multiplicar')
	println('')
	// https://docs.vlang.io/statements-&-expressions.html#range-for

	for tabla in 1 .. 11 {
		for num in 1 .. 11 {
			println('${tabla} * ${num} = ${tabla * num}')
		}
		println('')
	}
}
