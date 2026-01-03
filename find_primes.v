module main

fn is_prime(x int) bool {
	for i := 2; i <= x / 2; i++ {
		if x % i == 0 {
			return false
		}
	}
	return true
}

fn main() {
	println('numeros primos hasta el 200')
	println('')

	for i := 1; i <= 200; i++ {
		if is_prime(i) {
			print('${i} ')
		}
	}
	println('')
}
