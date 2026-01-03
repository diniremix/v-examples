module main

import net.websocket as socket
import net
import term
import log

fn main() {
	term.clear()
	log.info('Welcome to websocket(ws) server')
	log.info('starting websocketsocket(ws) server')

	opt := socket.ServerOpt{}

	addr := net.AddrFamily.ip

	log.info('listening on port 25575')

	mut server := socket.new_server(addr, 25575, '', opt)

	server.on_connect(fn (mut _ socket.ServerClient) !bool {
		log.info('client connection incomming')
		return true
	})!

	// fn (mut websocket.Client, int, string) !
	server.on_close(fn (mut _ socket.Client, code int, msg string) ! {
		log.warn('Conexión cerrada por el cliente.')
	})

	server.on_message(fn (mut client socket.Client, msg &socket.Message) ! {
		log.info('incoming message...')
		payload := msg.payload

		if payload.len > 0 {
			log.info('client: ${payload.bytestr()}')
		}
		client.write_string('hello client') or { return }
	})

	server.listen()!
}
