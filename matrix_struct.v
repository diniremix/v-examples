//- https://gitlab.com/HomeInside/callisto/-/blob/master/app/contrib/geospatial/matrix.py
// comprobaciones de matrices de distancia en V
// esta función usa un Struct y métodos

module main

struct Matrix {
	data [][]f64 // Usamos un array de arrays para representar la matriz
}

// Constructor para crear una nueva matriz
fn new_matrix(data [][]f64) Matrix {
	return Matrix{
		data: data
	}
}

// Obtener el número de filas
fn (m Matrix) rows() int {
	return m.data.len
}

// Obtener el número de columnas
fn (m Matrix) cols() int {
	return m.data[0].len
}

// Verificar si la matriz es simétrica
fn (m Matrix) is_symmetric() bool {
	if m.rows() != m.cols() {
		return false // No es cuadrada
	}
	for i in 0 .. m.rows() {
		for j in 0 .. m.cols() {
			if m.data[i][j] != m.data[j][i] {
				return false // No es simétrica
			}
		}
	}
	return true
}

// Verificar si la matriz es triangular
fn (m Matrix) is_triangular() bool {
	n := m.rows()
	for i in 0 .. n {
		for j in 0 .. n {
			for k in 0 .. n {
				if m.data[i][j] > m.data[i][k] + m.data[k][j] {
					println('La desigualdad triangular no se cumple para los puntos ${i + 1}, ${j +
						1} y ${k + 1}')
					return false // No es triangular
				}
			}
		}
	}
	return true
}

fn main() {
	// Crear una matriz 4x4
	matrix := new_matrix([
		[0.0, 7.74, 12.5, 17.06],
		[6.51, 0.0, 5.47, 10.03],
		[13.27, 6.95, 0.0, 3.5],
		[16.62, 10.29, 6.0, 0.0],
	])

	// Verificar simetría
	if matrix.is_symmetric() {
		println('La matriz es simétrica.')
	} else {
		println('La matriz no es simétrica.')
	}

	// Verificar desigualdad triangular
	if matrix.is_triangular() {
		println('La matriz es triangular.')
	} else {
		println('La matriz no es triangular.')
	}
}
