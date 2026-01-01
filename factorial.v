/*
	calcula el factorial de un numero
	genera un error de "attempt to multiply with overflow"

	- https://www.calculatorsoup.com/calculators/discretemathematics/factorials.php
*/
module main

import term
import os { get_line }

fn main() {
	term.clear()
	println('factorial de un numero')
	println('')

	println('Introduce un número entero (no muy grande)  ;-)')
	num := get_line()

	result := factorial(num.int())
	println('el factorial de ${num} es: ${result}')
}

fn factorial(a int) int {
	if a == 1 {
		return 1
	} else {
		return a * factorial(a - 1)
	}
}
