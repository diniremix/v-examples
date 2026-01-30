// Based on: morse. A rust crate to encode / decode ascii to a morse code representation
// https://github.com/NuclearCookie/morse
// https://github.com/diniremix/morse/
//

module main

fn encode(input string) !string {
	text := input.to_lower()
	mut result := []string{}
	mut error_values := []string{}

	for c in text.runes() {
		code := match c {
			`a` {
				'._'
			}
			`á` {
				'.__._'
			}
			`b` {
				'_...'
			}
			`c` {
				'_._.'
			}
			`d` {
				'_..'
			}
			`e` {
				'.'
			}
			`é` {
				'.._..'
			}
			`f` {
				'.._.'
			}
			`g` {
				'__.'
			}
			`h` {
				'....'
			}
			`i` {
				'..'
			}
			`í` {
				'..'
			}
			`j` {
				'.___'
			}
			`k` {
				'_._'
			}
			`l` {
				'._..'
			}
			`m` {
				'__'
			}
			`n` {
				'_.'
			}
			`ñ` {
				'__.__'
			}
			`o` {
				'___'
			}
			`ó` {
				'___.'
			}
			`p` {
				'.__.'
			}
			`q` {
				'__._'
			}
			`r` {
				'._.'
			}
			`s` {
				'...'
			}
			`t` {
				'_'
			}
			`u` {
				'.._'
			}
			`ú` {
				'.._'
			}
			`v` {
				'..._'
			}
			`w` {
				'.__'
			}
			`x` {
				'_.._'
			}
			`y` {
				'_.__'
			}
			`z` {
				'__..'
			}
			`æ` {
				'._._'
			}
			`ø` {
				'___.'
			}
			`å` {
				'.__._'
			}
			`ü` {
				'..__'
			}
			`0` {
				'_____'
			}
			`1` {
				'.____'
			}
			`2` {
				'..___'
			}
			`3` {
				'...__'
			}
			`4` {
				'...._'
			}
			`5` {
				'.....'
			}
			`6` {
				'_....'
			}
			`7` {
				'__...'
			}
			`8` {
				'___..'
			}
			`9` {
				'____.'
			}
			`.` {
				'._._._'
			}
			`,` {
				'__..__'
			}
			`¿` {
				'.._._'
			}
			`?` {
				'..__..'
			}
			`'` {
				'.____.'
			}
			`¡` {
				'__..._'
			}
			`!` {
				'_._.__'
			}
			`/` {
				'_.._.'
			}
			`(` {
				'_.__.'
			}
			`)` {
				'_.__._'
			}
			`&` {
				'._...'
			}
			`:` {
				'___...'
			}
			`;` {
				'_._._.'
			}
			`=` {
				'_..._'
			}
			`+` {
				'._._.'
			}
			`-` {
				'_...._'
			}
			`_` {
				'..__._'
			}
			`"` {
				'._.._.'
			}
			`$` {
				'..._.._'
			}
			`@` {
				'.__._.'
			}
			` ` {
				'/'
			}
			else {
				error_values << c.str()
				'#'
			}
		}
		result << code
		result << ' '
	}

	result.pop()

	if error_values.len == 0 {
		return result.join('')
	} else {
		return error('unsupported characters: ${error_values}')
	}
}

fn decode(input string) !string {
	text := input.replace('*', '.').replace('-', '_').trim('')
	mut result := []string{}
	mut error_values := []string{}

	words := text.split('/')

	for word in words {
		mut chars := word.trim('').split(' ')
		for c in chars {
			if c == '' {
				continue
			}

			letter := match c {
				'._' {
					'a'
				}
				'.__._' {
					'á'
				}
				'_...' {
					'b'
				}
				'_._.' {
					'c'
				}
				'_..' {
					'd'
				}
				'.' {
					'e'
				}
				'.._..' {
					'é'
				}
				'.._.' {
					'f'
				}
				'__.' {
					'g'
				}
				'....' {
					'h'
				}
				'..' {
					'i'
				}
				//'..' {'í'}
				'.___' {
					'j'
				}
				'_._' {
					'k'
				}
				'._..' {
					'l'
				}
				'__' {
					'm'
				}
				'_.' {
					'n'
				}
				'__.__' {
					'ñ'
				}
				'___' {
					'o'
				}
				'___.' {
					'ó'
				}
				'.__.' {
					'p'
				}
				'__._' {
					'q'
				}
				'._.' {
					'r'
				}
				'...' {
					's'
				}
				'_' {
					't'
				}
				'.._' {
					'u'
				}
				//'.._' {'ú'}
				'..._' {
					'v'
				}
				'.__' {
					'w'
				}
				'_.._' {
					'x'
				}
				'_.__' {
					'y'
				}
				'__..' {
					'z'
				}
				'._._' {
					'æ'
				}
				//'___.' {'ø'}
				//'.__._' {'å'}
				'..__' {
					'ü'
				}
				'_____' {
					'0'
				}
				'.____' {
					'1'
				}
				'..___' {
					'2'
				}
				'...__' {
					'3'
				}
				'...._' {
					'4'
				}
				'.....' {
					'5'
				}
				'_....' {
					'6'
				}
				'__...' {
					'7'
				}
				'___..' {
					'8'
				}
				'____.' {
					'9'
				}
				'._._._' {
					'.'
				}
				'__..__' {
					','
				}
				'.._._' {
					'¿'
				}
				'..__..' {
					'?'
				}
				'.____.' {
					"'"
				}
				'__..._' {
					'¡'
				}
				'_._.__' {
					'!'
				}
				'_.._.' {
					'/'
				}
				'_.__.' {
					'('
				}
				'_.__._' {
					')'
				}
				'._...' {
					'&'
				}
				'___...' {
					':'
				}
				'_._._.' {
					';'
				}
				'_..._' {
					'='
				}
				'._._.' {
					'+'
				}
				'_...._' {
					'-'
				}
				'..__._' {
					'_'
				}
				'._.._.' {
					'"'
				}
				'..._.._' {
					'$'
				}
				'.__._.' {
					'@'
				}
				'/' {
					' '
				}
				' ' {
					' '
				}
				else {
					error_values << c.str()
					'#'
				}
			}
			result << letter
		}
		result << ' '
	}

	result.pop()

	if error_values.len == 0 {
		return result.join('')
	} else {
		return error('unsupported characters: ${error_values}')
	}
}

fn main() {
	// text := 'Hello World!'.to_lower()
	text := 'El veloz murciélago hindú comía feliz cardillo y kiwi. La cigüeña ¡tocaba el saxofón detrás del palenque de paja!.'
	println('normal text: "${text}"')

	result := encode(text) or {
		panic('encode error: ${err}')
		return
	}
	println('')
	println('morse result: "${result}"')

	// result := '. ._.. / ..._ . ._.. ___ __.. / __ .._ ._. _._. .. .._.. ._.. ._ __. ___ / .... .. _. _.. .._ / _._. ___ __ .. ._ / .._. . ._.. .. __.. / _._. ._ ._. _.. .. ._.. ._.. ___ / _.__ / _._ .. .__ .. ._._._ / ._.. ._ / _._. .. __. ..__ . __.__ ._ / __..._ _ ___ _._. ._ _... ._ / . ._.. / ... ._ _.._ ___ .._. ___. _. / _.. . _ ._. .__._ ... / _.. . ._.. / .__. ._ ._.. . _. __._ .._ . / _.. . / .__. ._ .___ ._ _._.__ ._._._'
	result2 := decode(result)!
	println('')
	println('decode result: "${result2}"')
}
