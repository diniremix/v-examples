module main

import math

interface Figure {
	area() f64
}

struct Circle {
	radio f64
}

struct Rectangle {
	width  f64
	length f64
}

struct Square {
	length u32
}

fn (c Circle) area() f64 {
	return math.pi * math.square(c.radio)
}

fn (r Rectangle) area() f64 {
	return r.width * r.length
}

fn (s Square) area() f64 {
	return math.square(s.length)
}

fn main() {
	mut figures := []Figure{}
	circle := Circle{
		radio: 3.0
	}

	figures << circle

	figures << Rectangle{
		width:  4.0
		length: 5.0
	}

	for f in figures {
		println('f ${typeof(f).name} -> area: ${f.area()}')
	}

	sq := Square{
		length: 4
	}

	mut fig2 := Figure(sq)
	println('fig2 ${typeof(sq).name} -> area: ${fig2.area()}')
}
