computations = []

window.cssjsProperty = (selectors, property, fn) ->
	global = "this" not in fn
	if typeof fn is "string"
		fn = fn.replace ///\s*;\s*$///, ''
		fn = "function(){ #{fn} }" if ///^\s*return\s///.test fn
		fn = eval '(' + fn + ')'
	computations.push
		selectors: selectors
		property: property
		global: global
		fn: fn

normalize = (value) ->
	if typeof value is 'number'
		value + "px"
	else if not value
		null
	else
		value

process = (computation) ->
	$elements = $ computation.selectors.join ", "
	if computation.global
		value = normalize computation.fn()
		$elements.css computation.property, value
	else
		$elements.each ->
			value = normalize computation.fn.call @
			$(@).css computation.property, value

processAll = ->
	# start = (new Date).getTime()
	process computation for computation in computations
	# duration = (new Date).getTime() - start

# this gonna be much smarter :)
$(window).resize processAll
$(window).scroll processAll
$(document).ready processAll
