module main

import term

fn main() {
	term.clear()

	println('haversine cli')

	origin := [51.5223337, -0.7198055]
	destiny := [51.5226574, -0.7219567]

	println('')

	result_in_kms := haversine(origin, destiny, 'kms')

	println('result in kms: ${result_in_kms}')
	assert result_in_kms == 0.153

	println('')
	result_in_mts := haversine(origin, destiny, 'mts')

	println('result in mts: ${result_in_mts}')
	assert result_in_mts == 153.124
}
