/*
La sucesión de Fibonacci es una sucesión `Fn` de números
naturales definida de forma recursiva.

- https://www.calculatorsoup.com/calculators/discretemathematics/fibonacci-calculator.php
- https://rosettacode.org/wiki/Fibonacci_sequence
*/

module main

import term
// import os
import os { get_line }

fn main() {
	term.clear()
	println(term.green(('calcular numeros de fibonacci')))
	println('')
	println(term.green(('Introduce un valor:')))

	input_value := get_line()

	if input_value.int() <= 0 {
		println(term.red(('el valor debe ser un numero positivo mayor a cero')))
		println('saliendo...')
		return
	}

	result := fibonacci(input_value.int())
	println(term.green(('el fibonacci de ${input_value} es: ${result}')))
}

fn fibonacci(num int) int {
	if num < 2 {
		return num
	}
	return fibonacci(num - 1) + fibonacci(num - 2)
}
