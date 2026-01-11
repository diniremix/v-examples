module main

import json
import net.http

struct QueryData {
	latitude  string
	longitude string
	current   string
	timezone  string
}

// current_units
struct CurrentUnitsResp {
	time                      string
	interval                  string
	temperature_2m            string
	apparent_temperature      string
	precipitation             string
	precipitation_probability string
	weather_code              string
	cloudcover                string
	windspeed_10m             string
	winddirection_10m         string
	uv_index                  string
	relative_humidity_2m      string
	dewpoint_2m               string
	visibility                string
	surface_pressure          string
}

// current
struct CurrentResp {
	time                      string
	interval                  int
	temperature_2m            f32
	apparent_temperature      f32
	precipitation             f32
	precipitation_probability int
	weather_code              int
	cloudcover                int
	windspeed_10m             f32
	winddirection_10m         int
	uv_index                  f32
	relative_humidity_2m      int
	dewpoint_2m               f32
	visibility                f32
	surface_pressure          f32
}

// handle response
struct ResponseJson {
	latitude              f32
	longitude             f32
	generationtime_ms     f32
	utc_offset_seconds    int
	timezone              string
	timezone_abbreviation string
	elevation             f32
	current_units         CurrentUnitsResp
	current               CurrentResp
}

fn current_weather(lat f32, lng f32, tz string) !ResponseJson {
	base_uri := 'https://api.open-meteo.com/v1'
	forecast_uri := '/forecast'

	default_params := [
		'temperature_2m',
		'apparent_temperature',
		'precipitation',
		'precipitation_probability',
		'weather_code',
		'cloudcover',
		'windspeed_10m',
		'winddirection_10m',
		'uv_index',
		'relative_humidity_2m',
		'dewpoint_2m',
		'visibility',
		'surface_pressure',
	]

	params := default_params.join(',')

	// using Struct
	// q_data := QueryData{lat.str(), lng.str(), params, tz}
	q_data := QueryData{
		latitude:  lat.str()
		longitude: lng.str()
		current:   params
		timezone:  tz
	}

	enc_data := json.encode(q_data) // QueryData type
	encode_data := json.decode(map[string]string, enc_data)! // map[string]string type

	// using `map[string]string`
	/*mut encode_data := map[string]string{}
	encode_data = {
		'latitude':  lat.str()
		'longitude': lng.str()
		'current':   params
		'timezone':  tz
	}*/

	data := http.url_encode_form_data(encode_data) // string type

	url := '${base_uri}${forecast_uri}'

	resp := http.get('${url}?${data}') or {
		eprintln('failed to fetch data from ${url}')
		return ResponseJson{}
	}

	resp_body := json.decode(ResponseJson, resp.body) or { ResponseJson{} }

	return resp_body
}

fn main() {
	resp := current_weather(51.5186902, -0.1332287, 'Europe/London')!
	println('current_weather response')
	println(resp)
}
