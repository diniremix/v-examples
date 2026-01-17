// a cli app example
// - https://modules.vlang.io/flag.html
// - https://modules.vlang.io/cli.html
// - https://blog.vlang.io/the-complete-beginners-guide-to-cli-apps-in-v/
// - https://github.com/Dracks/repo-download-asset/
// - https://github.com/apoprotsky/portctl/
//
// examples:
// `./cli_app`
// `./cli_app help` | `./cli_app --help` | `./cli_app -h`
// `./cli_app version` | `./cli_app --version` | `./cli_app -v`
// `./cli_app run help`
// `./cli_app run`
// `./cli_app check help`
// `./cli_app check -f file_example.ext`
// `./cli_app check -f file_example.ext -o output_file.ext`
// `./cli_app check`
//
module main

import cli
import os

fn get_check_flags() []cli.Flag {
	return [
		cli.Flag{
			flag:        .string
			name:        'file'
			abbrev:      'f'
			description: 'file args example'
			required:    false // validate inside check command
		},
		cli.Flag{
			flag:        .string
			name:        'output'
			abbrev:      'o'
			description: 'output args example'
			required:    false
		},
	]
}

fn get_commands() []cli.Command {
	return [
		cli.Command{
			name:        'run'
			description: 'run subcommand example'
			// required_args: 1
			execute: fn (cmd cli.Command) ! {
				println('run command...')
				println('run args: ${cmd.args}')
				// println('run flags: ${cmd.flags}')
				if cmd.args.len > 0 && cmd.args[0] == 'help' {
					cmd.execute_help()
					return
				}
			}
		},
		cli.Command{
			name:        'check'
			description: 'check subcommand example'
			execute:     fn (cmd cli.Command) ! {
				println('check command...')
				println('check args: ${cmd.args}')
				// println('check flags: ${cmd.flags}')
				if cmd.args.len > 0 && cmd.args[0] == 'help' {
					cmd.execute_help()
					return
				}

				file := cmd.flags.get_string('file') or { '' }
				if file == '' {
					println('Flag `--file` | `-f` is required by `check`')
					exit(1)
				}
				output := cmd.flags.get_string('output') or { '' }
				println('check args [--file | -f]: ${file}')
				println('check args [--output | -o]: ${output}')
			}
			flags:       get_check_flags()
		},
	]
}

fn main() {
	mut app := cli.Command{
		name:        'cli_app'
		description: 'CLI app de ejemplo'
		version:     '1.0.0'
		posix_mode:  true
		commands:    get_commands()
	}
	app.setup()
	app.parse(os.args)
}
