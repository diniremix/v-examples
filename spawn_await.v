// `spawn foo()` runs `foo()` concurrently in a different thread
// - https://docs.vlang.io/concurrency.html#spawning-concurrent-tasks
// - https://github.com/vlang/v/blob/master/examples/concurrency/concurrency.v
//
// `spawn` – Lanza un hilo del sistema operativo (OS thread). Adecuado para
// tareas pesadas, ejecución paralela real y menos predecible en orden de ejecución.
//
// en este ejemplo: se utiliza `sync.WaitGroup` para esperar a que todas las tareas terminen.
//

module main

import time
import sync

fn heavy_task(i int, mut wg sync.WaitGroup) {
	print('working in a thread task: ${i}\n')
	time.sleep(1 * time.second)
	wg.done()
}

fn main() {
	mut wg := sync.new_waitgroup()
	total := 10
	wg.add(total)

	for i in 1 .. 11 {
		spawn heavy_task(i, mut wg)
	}

	println('waiting...')
	wg.wait()
	println('all done!')
}
