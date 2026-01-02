module main

import term

fn main() {
	term.clear()
	println('ordenamiento usando burbuja')
	println('')
	mut num_arrays := [8, 7, 1, 4, 9, 42, -1, 6, 2, 5, 0, 3]
	println('elementos antes: ${num_arrays}')
	result := bubble_sort(mut num_arrays)
	println('elementos ordenados: ${result}')
}

fn bubble_sort(mut values []int) []int {
	mut n := values.len
	println('cantidad de elementos a ordernar: ${n}')

	for {
		for i in 1 .. n {
			if values[i - 1] > values[i] {
				a := values[i]
				values[i] = values[i - 1]
				values[i - 1] = a
			}
		}
		n -= 1
		if n <= 1 {
			break
		}
	}
	return values
}
