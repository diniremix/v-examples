// una implementación sencilla de un autómata celular
// basado en la Hormiga de Langton.
// - https://en.wikipedia.org/wiki/Langton%27s_ant
module main

import rand
import term
import time

const max_gen = 1000 // 1000

enum Orientation {
	up
	right
	down
	left
}

const board_height = 24
const board_width = 50

fn get_board(color string) ![][]int {
	mut color_board := match color {
		'BLACK' {
			[][]int{len: board_height, init: []int{len: board_width, init: u8(0)}}
		}
		'WHITE' {
			[][]int{len: board_height, init: []int{len: board_width, init: u8(1)}}
		}
		else {
			mut board := [][]int{len: board_height, init: []int{len: board_width}}
			for i in 0 .. board_height {
				for j in 0 .. board_width {
					board[i][j] = rand.intn(2)!
				}
			}
			board
		}
	}

	return color_board
}

fn draw_change_cell(x int, y int, cell_color int) {
	// compensar el desface entre el
	// tablero y la terminal
	term.set_cursor_position(x: x + 19, y: y + 1)

	if cell_color == 0 {
		print(term.bg_black(term.white('░')))
	} else if cell_color == 1 {
		print(term.bg_white(term.black('█')))
	}
}

fn draw_ant(x int, y int) {
	// compensar el desface entre el
	// tablero y la terminal
	term.set_cursor_position(x: x + 19, y: y + 1)
	print(term.bg_red(term.white('^')))

	// draw score menu pos X
	term.set_cursor_position(x: 4, y: 2)
	print(x)

	// draw score menu pos Y
	term.set_cursor_position(x: 4, y: 3)
	print(y)
}

fn draw_score(gen int, ori Orientation) {
	// print gen
	term.set_cursor_position(x: 6, y: 5)
	print('${gen}/${max_gen}')
	// print orientation
	term.set_cursor_position(x: 11, y: 7)
	print('        ')
	term.set_cursor_position(x: 11, y: 7)
	print(' -${ori}-')
}

fn print_menu() {
	term.set_cursor_position(x: 0, y: 0)
	print('ant version: 1.0')
	term.set_cursor_position(x: 0, y: 2)
	print('Y:')
	term.set_cursor_position(x: 0, y: 3)
	print('X:')
	term.set_cursor_position(x: 0, y: 5)
	print('Gen:')
	term.set_cursor_position(x: 0, y: 7)
	print('Direction:')
	term.set_cursor_position(x: 0, y: 22)
	print('Exit:')
	term.set_cursor_position(x: 0, y: 23)
	print('- Ctrl+C')
}

fn print_board(grid [][]int) {
	for row in 0 .. board_height {
		for col in 0 .. board_width {
			cell := grid[row][col]
			mut color := '░'

			if cell == 0 {
				color = '░'
			} else if cell == 1 {
				color = '█'
			}
			term.set_cursor_position(x: col + 19, y: row + 1)
			print(color)
		}
	}
	println('')
}

fn init_game(mut color_board [][]int) {
	mut x := 12 // 24 max
	mut y := 13 // 50 max //24
	mut ori := Orientation.up
	mut cell := 0 // color negro

	mut i := 0

	for gen in 0 .. max_gen {
		if (x >= 0 && x <= color_board.len) && (y >= 0 && y <= color_board[x].len) {
			p_x := x
			p_y := y
			p_cell := cell

			cell = color_board[x][y]

			if cell == 0 {
				color_board[x][y] = 1
				match ori {
					.up {
						ori = .right
						y += 1
						// println('move to up')
					}
					.right {
						ori = .down
						x += 1
						// println('move to right')
					}
					.down {
						ori = .left
						y -= 1
						// println('move to down')
					}
					.left {
						ori = .up
						x -= 1
						// println('move to left')
					}
				}
			} else if cell == 1 {
				color_board[x][y] = 0
				match ori {
					.up {
						ori = .left
						y -= 1
						// println('move to left')
					}
					.right {
						ori = .up
						x -= 1
						// println('move to up')
					}
					.down {
						ori = .right
						y += 1
						// println('move to right')
					}
					.left {
						ori = .down
						x += 1
						// println('move to down')
					}
				}
			}

			draw_score(gen, ori)
			draw_change_cell(p_x, p_y, p_cell)
			draw_ant(x, y)

			i += 1
			time.sleep(10 * time.millisecond) // rapido
			// time.sleep(250 * time.millisecond) // lento
		}
	}
	term.set_cursor_position(term.Coord{1, 28})
	println('gen: ${i} -> skips: ${max_gen - i}')
}

fn main() {
	term.clear()
	width, height := term.get_terminal_size() // get the size of the terminal
	if height < 25 {
		println('console screen width:${width} height:${height}')
		println('console screen height must be 25 at least')
		return
	}

	mut board := get_board('WHITE')! // WHITE | BLACK |random
	term.hide_cursor()
	print_board(board)
	print_menu()
	init_game(mut board)
	term.show_cursor()
}
