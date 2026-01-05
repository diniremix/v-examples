module main

import rand { uuid_v4, uuid_v7 }

fn main() {
	// rand
	r_b := rand.bytes(32)!
	println('rand.bytes: ${r_b}')

	r_u32 := rand.u32()
	println('rand.u32: ${r_u32}')

	r_f32 := rand.f32()
	println('rand.f32: ${r_f32}')

	r_ascii := rand.ascii(12)
	println('rand.ascii: ${r_ascii}')

	r_string := rand.string(12)
	println('rand.string: ${r_string}')

	r_intn := rand.intn(100)!
	println('rand.r_intn: ${r_intn}')

	// uuid_v4
	uidv4 := uuid_v4()
	println('uidv4: ${uidv4}')

	// uuid_v7
	uidv7 := uuid_v7()
	println('uidv7: ${uidv7}')

	names_list := ['Alice', 'Bob', 'Charlie', 'Dana']
	winner := names_list[rand.intn(names_list.len)!]
	println('Ganador: ${winner}')

	shuffled := rand.shuffle_clone[string](names_list)!
	println('Orden aleatorio: ${shuffled}')
}
