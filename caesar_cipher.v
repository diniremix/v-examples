// https://en.wikipedia.org/wiki/Caesar_cipher
// https://en.wikipedia.org/wiki/ROT13
// https://rosettacode.org/wiki/Rot-13
// https://docs.vlang.io/v-types.html#runes
//
// cifrado cesar, utilizando ROT13
// esta versión utiliza `rune`

fn rot13(text string) string {
	mut result := []rune{}
	shift := 13
	alpha_chars := 26

	for chr in text.runes() {
		// a-z
		if chr >= u8(97) && chr <= u8(122) {
			mut ord := (chr - 97) + shift
			ord = (ord % alpha_chars) + 97

			result << ord
		}
		// A-Z
		else if chr >= u8(65) && chr <= u8(90) {
			mut ord := (chr - 65) + shift
			ord = (ord % alpha_chars) + 65

			result << ord
		} else {
			result << chr
		}
	}

	// convert `[]rune` to string
	return result.string()
}

fn main() {
	mut text := 'nowhere ABJURER'
	mut result_chiper := rot13(text)

	assert result_chiper == 'abjurer NOWHERE'
	println('cipher text: ${result_chiper}')

	mut result_text := rot13(result_chiper)
	assert result_text == text
	println('original text: ${result_text}')

	println('')

	// The Wikipedia example uses a right offset of 23
	// instead of the classic 13.
	text = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG'
	result_chiper = rot13(text)

	assert result_chiper == 'GUR DHVPX OEBJA SBK WHZCF BIRE GUR YNML QBT'
	println('cipher text: ${result_chiper}')

	result_text = rot13(result_chiper)
	assert result_text == text
	println('original text: ${result_text}')
}
