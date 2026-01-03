// A pure V implementation of Haversine formula
// Based on Bartek Górny implementation and others.
//
// Author: Jorge Brunal Perez <diniremix@gmail.com>
//
// [Oxide/haversine](https://gitlab.com/HomeInside/Oxide/-/blob/master/src/utils/haversine.rs)
// commit: bfbe832323f6
//
// ## Examples
// How to use:
//
// ```v
// origin := [51.5223337, -0.7198055]
// destiny := [51.5226574, -0.7219567]
//
// result_in_kms := haversine(origin, destiny, 'kms')
// println('result in kms: ${result_in_kms}')
//
// // Otherwise
// result_in_mts := haversine(origin, destiny, 'mts')
// println('result in mts: ${result_in_mts}')
// ```
//
import math

@[export: 'haversine']
fn haversine(orig []f64, dest []f64, type_measure string) f64 {
	radius := f64(6371) // R
	rad := math.pi / f64(180) // RAD
	second := f64(2) // SECOND
	orig_lat := orig[0]
	orig_lon := orig[1]

	dest_lat := dest[0]
	dest_lon := dest[1]

	delta_lat := (dest_lat - orig_lat) * rad
	delta_lon := (dest_lon - orig_lon) * rad

	rad_orig_lat := orig_lat * rad
	rad_dest_lat := dest_lat * rad

	a := math.pow(math.sin(delta_lat / second), 2) +
		math.cos(rad_orig_lat) * math.cos(rad_dest_lat) * math.pow(math.sin(delta_lon / second), 2)

	c := second * math.sin(math.sqrt(a))
	d := radius * c

	if type_measure == 'kms' {
		println('type_measure results in kms!')

		// return d
		return '${d:.3f}'.f64()
	} else {
		println('type_measure results in meters')

		// format!("{:.3}", d * 1000f64).parse().unwrap()
		//
		// return f64(d * 1000)
		//
		// return '${(d * f64(1000)):.3f}'.f64()
		//
		mts := d * f64(1000)
		return '${mts:.3f}'.f64()
	}
}
