css = require 'css'

cssjs = (input, opts) ->
	cssAST = css.parse input
	scripts = []
	cssAST.stylesheet.rules.forEach (rule) ->
		rule.declarations.forEach (declaration) ->
			if declaration.script
				scripts.push
					selectors: rule.selectors
					property: declaration.property
					script: declaration.script
	css: css.stringify cssAST
	js: if not scripts.length then null else (for script in scripts
		if script.property
			"cssjsProperty(#{JSON.stringify script.selectors}, #{JSON.stringify script.property}, #{JSON.stringify script.script});"
		else
			"// unknown script"
	).join "\n"

module.exports = cssjs
