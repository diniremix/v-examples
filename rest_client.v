module main

import net.http
import term
import json

struct User {
mut:
	username string
	avatar   string
}

// handle response
struct ResponseJson {
	args    map[string]string @[json: '-']
	data    string            @[json: '-']
	files   map[string]string @[json: '-']
	form    map[string]string @[json: '-']
	headers map[string]string @[json: '-']
	json    User // User type
	origin  string @[json: '-']
	url     string @[json: '-']
}

fn main() {
	println('cliente rest')
	println('')

	println(term.green('method: GET'))

	resp_get := http.get('https://httpbin.org/get') or {
		eprintln('failed to fetch data from /get')
		return
	}
	println('la resp es: ${resp_get}')

	println('')
	println(term.green('method: POST'))

	data := "{'a':1, 'b':2}"
	resp_post := http.post_json('https://httpbin.org/post', data) or {
		eprintln('failed to fetch data from /post')
		return
	}
	println('la resp es: ${resp_post}')

	println('')
	println(term.green('method: PUT'))

	resp_put := http.put('https://httpbin.org/put', data) or {
		eprintln('failed to fetch data from /put')
		return
	}
	println('la resp es: ${resp_put}')

	println('')
	println(term.green('method: DELETE'))

	resp_del := http.delete('https://httpbin.org/delete') or {
		eprintln('failed to fetch data from /delete')
		return
	}
	println('la resp es: ${resp_del}')

	println('')

	println(term.green('method: POST usando structs'))

	user := User{'Peter', '/pictures/avatars/user1.png'}
	enc_user := json.encode(user)
	println('user es: ${user}')
	println('encode user es: ${enc_user}')

	mut dec_user := json.decode(User, enc_user)!
	println('decode user es: ${dec_user}')

	println('')
	resp := http.post_json('https://httpbin.org/post', enc_user) or {
		eprintln('failed to fetch data from /post')
		return
	}
	println('resp es: ${resp}')
	println('')
	println('raw_body es: ${resp.body}')
	println('')
	resp_body := json.decode(ResponseJson, resp.body)!

	println('resp_body es: ${resp_body.json}')
}
