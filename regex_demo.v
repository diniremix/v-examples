// regex usando pcre
// `v install pcre`
// - https://regex101.com/
// - https://modules.vlang.io/regex.html
module main

import pcre

fn validate_email(email string) bool {
	r := pcre.new_regex(r'^((?!\.)[\w\-_.+]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$', 0) or {
		return false
	}

	defer {
		r.free()
	}

	m := r.match_str(email, 0, 0) or { return false }
	result := m.get(0) or { return false }

	return result == email
}

fn main() {
	println(validate_email('usuarioejemplo.com'))
	println(validate_email('usuario@ejemplo.com'))
	println(validate_email('testmail@mail.com.'))
	println(validate_email('.testmail@mail.com'))
	println(validate_email('testmail@mail.de.org'))
	println(validate_email('testmail.demo@mail.rg'))
	println(validate_email('lama.llama.loca123@inca.com'))
	println(validate_email('testmail+demo@mail.com'))
	println(validate_email(' testmail@mail.com'))
	println(validate_email('testmail.demo+one@mail.com'))
	println(validate_email('testmail+two.three@mail.com'))
	println(validate_email('testmail+two.three+four@mail.com'))
}
