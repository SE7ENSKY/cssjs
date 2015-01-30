fs = require 'fs'
path = require 'path'
basename = path.basename
dirname = path.dirname
resolve = path.resolve
exists = fs.existsSync or path.existsSync
join = path.join

program = require 'commander'
monocle = require('monocle')()
mkdirp = require 'mkdirp'

cssjs = require '..'

program
	.version(require('../package.json').version)
	.usage('[options] [dir|file ...]')
	.option('-o, --out <dir>', 'output the processed files to <dir>')
	.option('-w, --watch', 'watch files for changes and automatically re-render')

program.parse process.argv

processFile = (path) ->
	fs.lstat path, (err, stat) ->
		throw err  if err
		
		if stat.isFile() and ///\.css$///.test(path) and not (///\.css\.css$///.test(path) or ///\.css\.js$///.test(path))
			fs.readFile path, "utf8", (err, str) ->
				throw err  if err
				console.log "  \u001b[90mprocessing \u001b[36m%s\u001b[0m", path
				processed = cssjs str
				outPath = if program.out
					join program.out, basename(path)
				else
					path
				cssOutPath = outPath + ".css"
				jsOutPath = outPath + ".js"

				dir = resolve dirname outPath
				mkdirp dir, 0o755, (err) ->
					throw err	if err
					try
						if processed.css
							fs.writeFile cssOutPath, processed.css, (err) ->
								throw err  if err
								console.log "  \u001b[90mrendered \u001b[36m%s\u001b[0m", cssOutPath
						if processed.js
							fs.writeFile jsOutPath, processed.js, (err) ->
								throw err  if err
								console.log "  \u001b[90mrendered \u001b[36m%s\u001b[0m", jsOutPath

					catch e
						if options.watch
							console.error e.stack or e.message or e
						else
							throw e
		else if stat.isDirectory()
			fs.readdir path, (err, files) ->
				throw err	if err
				files
					.map (filename) -> path + "/" + filename
					.forEach processFile

files = program.args
if files.length
	console.log()
	if program.watch
		process.on "uncaughtException", (err) ->
			console.error err

		files.forEach processFile
		monocle.watchFiles
			files: files
			listener: (file) ->
				console.log "changed", file
				processFile file.absolutePath

	else
		files.forEach processFile
	process.on "exit", ->
		console.log()
else
	processFile "."