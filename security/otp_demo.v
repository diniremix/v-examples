// ejemplo para generar claves de un solo uso
// `v install meeds122.totp`
// - https://it-tools.tech/otp-generator
module main

import meeds122.totp
// import encoding.base32
// import rand
import time

const default_time = 30
const default_digits = 6

fn gen_otp_secret() !string {
	// using `totp.generate_secret`
	hex_string := totp.generate_secret(20)!

	// a manual approach
	// bytes := rand.bytes(20)! // 160bits
	// hex_string := base32.encode_to_string(bytes)

	// same result
	return hex_string
}

// generar codigo OTP
fn gen_totp(secret string) !string {
	auth := totp.Authenticator{
		secret:    secret
		time_step: default_time
		digits:    default_digits
	}
	code := auth.generate_totp(time.now().unix())!
	return code
}

// validar un codigo OTP
fn validate_totp(token string, secret string) !bool {
	auth := totp.Authenticator{
		secret:    secret
		time_step: default_time
		digits:    default_digits
	}
	return auth.check(token, 0)!
}

// genera una URI de aprovisionamiento
fn generate_uri(secret string, email string, app_name string) string {
	auth := totp.Authenticator{
		secret:    secret
		time_step: default_time
		digits:    default_digits
	}
	uri := auth.generate_uri(app_name, email)
	return uri
}

fn main() {
	secret := gen_otp_secret()!
	println('secret: ${secret}')

	otp_code := gen_totp(secret)!
	println('otp_code: ${otp_code}')

	is_valid := validate_totp(otp_code, secret)!
	println('is_valid: ${is_valid}')

	email := 'awesome_user@example.org'
	result_uri := generate_uri(secret, email, 'v_app_name')
	println('result_uri: ${result_uri}')
}
