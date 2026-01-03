module main

import term
import net.websocket as socket
import log

fn main() {
	term.clear()

	log.info('welcome to V')
	log.info('starting websocket(ws) client')

	opt := socket.ClientOpt{}

	mut client := socket.new_client('http://127.0.0.1:25575', opt)!

	client.connect()!

	client.write_string('hello server, from ws client')!

	// client.on_message(fn (msg string) {
	client.on_message(fn (mut _ socket.Client, msg &socket.Message) ! {
		// println('[mensaje recibido raw]: ${msg}')
		payload := msg.payload
		println('[mensaje recibido]: "${payload.bytestr()}"')
		// log.info(msg.bytestr())
	})

	client.on_error(fn (mut _ socket.Client, err string) ! {
		log.error('Error de conexión: ${err}')
	})

	client.on_close(fn (mut _ socket.Client, code int, msg string) ! {
		log.warn('Conexión cerrada por el servidor.')
	})

	client.listen() or {}
}
