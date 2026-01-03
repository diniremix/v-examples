// - https://github.com/vlang/v/blob/master/examples/coroutines/simple_coroutines.v
// - https://github.com/vlang/v/blob/master/examples/concurrency/concurrency_http.v
//
// `go` – Lanza una coroutine ligera de V. son ideales para tareas concurrentes
// rápidas y de bajo overhead. todas corren en el mismo hilo, No garantiza orden de
// ejecución.
//
// en este ejemplo: main termina antes de que las tareas concluyan, los hilos se interrumpen
// y el programa termina prematuramente, se necesita `sync.WaitGroup` o leer de un canal
// para esperar a que todas las tareas terminen.
//

module main

import time

fn light_task(i int) {
	print('working in a go-thread task: ${i}')
	time.sleep(1 * time.second)
}

fn main() {
	for i in 1 .. 11 {
		go light_task(i)
	}
}
