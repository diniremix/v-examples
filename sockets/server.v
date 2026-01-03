module main

import net
import term
import log

fn main() {
	term.clear()

	mut listener := net.listen_tcp(.ip6, ':25575') or {
		println(term.red('Error al abrir puerto: ${err}'))
		return
	}

	laddr := listener.addr()!
	println(term.green('Servidor TCP ${laddr}, escuchando en el puerto 25575...'))

	for {
		mut conn := listener.accept() or {
			println(term.yellow('Error al aceptar conexión: ${err}'))
			continue
		}
		client_addr := conn.peer_addr() or { return }
		println(term.green('Cliente conectado desde ${client_addr}'))

		mut buffer := []u8{len: 1024}
		n := conn.read(mut buffer) or {
			println(term.red('Error al leer del cliente: ${err}'))
			continue
		}

		data := buffer[..n].bytestr()
		log.info(term.green('Mensaje recibido: "${data}"'))
		log.info(term.green('enviando respuesta al cliente...'))

		conn.write('Hola desde el servidor TCP\n'.bytes()) or {
			println(term.red('Error al responder: ${err}'))
		}

		conn.close() or { println(term.red('Error al cerrar conexión')) }
	}
}
