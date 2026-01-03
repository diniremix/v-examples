// x.json2 is an experimental JSON parser written from scratch on V.
// https://modules.vlang.io/x.json2.html
module main

import net.http
import term
import x.json2

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
	println('cliente rest usando x.json2')
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

	enc_opt := json2.EncoderOptions{
		prettify:       false
		escape_unicode: true
	}
	user := User{'Peter', '/pictures/avatars/user1.png'}
	enc_user := json2.encode[User](user, enc_opt)
	println('user es: ${user}')
	println('encode user es: ${enc_user}')

	dec_user := json2.decode[User](enc_user)!
	println('decode user es: ${dec_user}')

	println('')
	resp := http.post_json('https://httpbin.org/post', enc_user) or {
		eprintln('failed to fetch data from /post')
		return
	}
	println('la resp es: ${resp}')

	// This returns an Any type
	resp_body := json2.decode[json2.Any](resp.body)!
	println('resp_body (json2.Any) es: ${resp_body}')
	println('')

	// mapping response
	json_resp := json2.decode[ResponseJson](resp.body)!
	println('resp_body es: ${json_resp}')
}
