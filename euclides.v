/*
	es un método eficiente para calcular el máximo común divisor (MCD)
	de dos números enteros, el número más grande que los divide
	a ambos sin dejar resto.

	- https://es.wikipedia.org/wiki/Algoritmo_de_Euclides
	- https://www.calculatorsoup.com/calculators/math/gcf-euclids-algorithm.php
	- https://rosettacode.org/wiki/Greatest_common_divisor
	ejemplos:
		- 48, 18 -> 6
		- 47, 14 -> 1
		- 80, 19 -> 1
		- 80675, 21945 -> 35
*/
module main

import term
import os { get_line }

fn main() {
	term.clear()
	println('1. Introduce un número entero (no muy grande)  ;-)')
	num1 := get_line()
	println('')
	println('2. Introduce un número entero (no muy grande)  ;-)')
	num2 := get_line()

	result := mcd(num1.int(), num2.int())
	println('el MCD es: ${result}')
}

fn mcd(a int, b int) int {
	if b == 0 {
		return a
	} else {
		return mcd(b, a % b)
	}
}
