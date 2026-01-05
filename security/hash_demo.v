module main

import crypto.sha256
import crypto.sha512
import crypto.blake3

fn main() {
	// sha256
	hello_hash := sha256.hexhash('hello world')
	println('hello_hash: ${hello_hash}')

	v_hash256 := sha256.hexhash('V')
	println('v_hash256: ${v_hash256}')
	assert sha256.hexhash('V') == v_hash256

	// sha512
	v_hash512 := sha512.hexhash('V')
	println('v_hash512: ${v_hash512}')

	assert sha512.hexhash('V') == v_hash512

	// blake3
	v_hash_blake := blake3.sum256('V'.bytes())
	println('v_hash_blake: ${v_hash_blake}')

	assert blake3.sum256('V'.bytes()) == v_hash_blake
	assert blake3.sum256('V'.bytes()).hex() == v_hash_blake.hex()

	// blake3 Digest stream
	mut blake3_digest := blake3.Digest.new_hash()!
	blake3_digest.write('V'.bytes())!
	blake3_digest.write('is'.bytes())!
	blake3_digest.write('awesome'.bytes())!

	checksum := blake3_digest.checksum(blake3.size256)

	println('blake3 digest checksum: ${checksum}')
	println('blake3 digest checksum (hex): ${checksum.hex()}')
}
