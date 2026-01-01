module main

import term

fn main() {
	term.clear()
	println('fizzbuzz')

	mut n := 1
	println('')

	for n < 101 {
		if n % 15 == 0 {
			println('fizzbuzz')
		} else if n % 3 == 0 {
			println('fizz')
		} else if n % 5 == 0 {
			println('buzz')
		} else {
			println(n)
		}
		n += 1
	}
}
