fn main() {
	// ascii code to char
	from_rune := rune(97) // 'a'
	println('character (using rune): ${from_rune}')
	from_u8 := u8(97).ascii_str()
	println('from_u8 (using u8): ${from_u8}')

	println('')
	// char to ascii code
	// using index
	vowel := 'a'
	code := vowel[0] // byte (u8)
	println('vowel: ${vowel} -> to u8: ${code} -> type: ${typeof(code).name}') // 97

	// using to int
	sp_char := `ñ`
	sp_code := int(sp_char)
	println('sp_char: ${sp_char} -> sp_char int: ${sp_code} -> type: ${typeof(sp_code).name}') // 97

	println('')
	text := '😆😊😎🥳👾😈🤡💀💩🙊🙉🙈💯💥'

	for r in text.runes() {
		ascii := int(r)
		println('char: ${r}, code: ${ascii} -> ${rune(ascii)}')
	}
}
