module main

import term
import os

fn main() {
	term.clear()
	println(term.green(('Introduce un valor:')))

	input_value := os.get_line()

	if input_value.int() <= 0 {
		println(term.red(('el valor debe ser un numero positivo mayor a cero:')))
		println('saliendo...')
		return
	}

	println('generando fibonacci de: ${input_value}')

	mut a := i64(0)
	mut b := i64(0)
	mut c := i64(1)

	println(a + b + c)

	for _ in 0 .. input_value.int() {
		// Set a and b to the next term
		a = b
		b = c
		// Compute the new term
		c = a + b
		// Print the new term
		println(c)
	}
}
