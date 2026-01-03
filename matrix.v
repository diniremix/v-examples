// comprobaciones de matrices de distancia en V

module main

fn rows(matriz [][]f64) int {
	return matriz.len
}

fn cols(matriz [][]f64) int {
	return matriz[0].len
}

// Verificar si la matriz es simétrica
fn is_symmetric(matriz [][]f64) bool {
	m_rows := rows(matriz)
	m_cols := cols(matriz)

	if m_rows != m_cols {
		return false // No es cuadrada
	}
	for i in 0 .. m_rows {
		for j in 0 .. m_cols {
			if matriz[i][j] != matriz[j][i] {
				return false // No es simétrica
			}
		}
	}
	return true
}

fn is_triangular(matriz [][]f64) bool {
	m_rows := rows(matriz)

	for i in 0 .. m_rows {
		for j in 0 .. m_rows {
			for k in 0 .. m_rows {
				//
				if matriz[i][j] > matriz[i][k] + matriz[k][j] {
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
	mut matriz := [][]f64{}

	matriz = [
		[0.0, 7.74, 12.5, 17.06],
		[6.51, 0.0, 5.47, 10.03],
		[13.27, 6.95, 0.0, 3.5],
		[16.62, 10.29, 6.0, 0.0],
	]

	println('rows: ${rows(matriz)}')
	println('cols: ${cols(matriz)}')

	// Verificar simetría
	if is_symmetric(matriz) {
		println('La matriz es simétrica.')
	} else {
		println('La matriz no es simétrica.')
	}

	// Verificar desigualdad triangular
	if is_triangular(matriz) {
		println('La matriz es triangular.')
	} else {
		println('La matriz no es triangular.')
	}

	return
}
