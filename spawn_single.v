// `spawn foo()` runs `foo()` concurrently in a different thread
// - https://docs.vlang.io/concurrency.html#spawning-concurrent-tasks
// - https://github.com/vlang/v/blob/master/examples/concurrency/concurrency.v
//
// `spawn` – Lanza un hilo del sistema operativo (OS thread). Adecuado para
// tareas pesadas, ejecución paralela real y menos predecible en orden de ejecución.
//
// en este ejemplo: main termina antes de que las tareas concluyan, los hilos se interrumpen
// y el programa termina prematuramente, se necesita `sync.WaitGroup` o leer de un canal
// para esperar a que todas las tareas terminen.
//

module main

import time

fn heavy_task(i int) {
	println('Tarea pesada: ${i}')
	time.sleep(1 * time.second)
}

fn main() {
	for i in 1 .. 11 {
		spawn heavy_task(i)
	}

	println('all done!')
}
