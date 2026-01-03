module main

fn test_haversine_1() {
	origin := [51.5223337, -0.7198055]
	destiny := [51.5226574, -0.7219567]

	result_in_kms := haversine(origin, destiny, 'kms')

	println('result in kms: ${result_in_kms}')
	assert result_in_kms == 0.153
}

fn test_haversine_2() {
	origin := [51.5223337, -0.7198055]
	destiny := [51.5226574, -0.7219567]
	result_in_mts := haversine(origin, destiny, 'mts')

	println('result in mts: ${result_in_mts}')
	assert result_in_mts == 153.124
}
