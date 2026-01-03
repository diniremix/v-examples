module main

//
// Note: This program, requires that the shared library was already compiled.
// To do so, run `v -d no_backtrace -o library -shared modules/library/library.v`
// before running this program.
//
import os
import dl
import dl.loader
import term
import v.vmod

type FNAdder = fn ([]f64, []f64, string) f64

// const cfolder = os.dir(@FILE)
const cfolder = os.dir(os.executable())

const default_paths = [
	os.join_path(cfolder, 'haversinelib1${dl.dl_ext}'),
	os.join_path('plugins', 'haversinelib1${dl.dl_ext}'),
	os.join_path('libs', 'haversinelib1${dl.dl_ext}'),
]

fn main() {
	mod := vmod.decode(@VMOD_FILE) or { panic('Error decoding v.mod') }
	term.clear()
	println('loading a dynamic library using V')
	println('${mod.name} v.${mod.version}')
	println('')
	println('executable path: ${cfolder}')
	println('library paths to search:')

	for item in default_paths {
		println('- path: ${item}')
	}

	println('')

	mut dl_loader := loader.get_or_create_dynamic_lib_loader(
		// key: cfolder
		key:   'haversine'
		paths: default_paths
	)!

	defer {
		println('')
		println(term.yellow('trying unloading library...'))
		dl_loader.unregister()
		println(term.green('trying unloading library OK!'))
	}

	sym := dl_loader.get_sym('haversine') or {
		eprintln(term.yellow('Unable to find symbol...'))
		eprintln(term.red('Error: ${err}'))
		return
	}

	f := FNAdder(sym)
	println('function info: ${ptr_str(f)}')

	println('calling function...')
	origin := [51.5223337, -0.7198055]
	destiny := [51.5226574, -0.7219567]
	result_as := 'mts'

	res := f(origin, destiny, result_as)
	println('function result: ${res}')
}
