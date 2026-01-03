module main

import net
import term

fn main() {
	println(term.green('Conectando al servidor TCP..'))

	mut conn := net.dial_tcp('127.0.0.1:25575') or {
		eprintln('Error al conectar: ${err}')
		return
	}

	println(term.green('Conectado al servidor.'))

	conn.write('hello from V client'.bytes()) or { eprintln('Error al enviar: ${err}') }

	// Leer respuesta del servidor
	mut buffer := []u8{len: 1024}
	n := conn.read(mut buffer) or {
		println(term.yellow('Error al leer: ${err}'))
		return
	}

	println('Respuesta del servidor: ${buffer[..n].bytestr()}')
	println('cerrando cliente...')

	conn.close() or { println(term.red('Error al cerrar conexión: ${err}')) }
}
