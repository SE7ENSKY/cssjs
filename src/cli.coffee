program = require 'commander'
monocle = require('monocle')()
mkdirp = require 'mkdirp'
cssjs = require '..'

program
	.version(require('../package.json').version)
	.usage('[options] [dir|file ...]')
	.option('-o, --out <dir>', 'output the compiled html to <dir>')
	.option('-P, --pretty', 'compile pretty CSS output')
	.option('-w, --watch', 'watch files for changes and automatically re-render')

program.parse process.argv

# cssjs "some input", any: "opts", go: "here"

console.log "ToDo"
