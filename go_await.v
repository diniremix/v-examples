// - https://github.com/vlang/v/blob/master/examples/coroutines/simple_coroutines.v
// - https://github.com/vlang/v/blob/master/examples/concurrency/concurrency_http.v
//
// `go` – Lanza una coroutine ligera de V. son ideales para tareas concurrentes
// rápidas y de bajo overhead. todas corren en el mismo hilo, No garantiza orden de
// ejecución.
//
// en este ejemplo: se utiliza `sync.WaitGroup` para esperar a que todas las tareas terminen.
//
module main

import time
import sync

fn light_task(i int, mut wg sync.WaitGroup) {
	print('working in a go-thread task: ${i}\n')
	time.sleep(1 * time.second)
	wg.done()
}

fn main() {
	mut wg := sync.new_waitgroup()
	total := 10
	wg.add(total)

	for i in 1 .. 11 {
		go light_task(i, mut wg)
	}

	println('waiting...')
	wg.wait()
	println('all done!')
}
