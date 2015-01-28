require('chai').should()

cssjs = require '../src/cssjs'

describe 'cssjs', ->
	it 'basic test', ->
		cssjs """
			.selector {
				top: 0;
				height: return window.height - 56;
				width: 100px;
			}
		"""
		.should.eql [
			"""
				.selector {
				  top: 0;
				  /* height: return window.height - 56; */
				  width: 100px;
				}
			"""
			"""
				cssjsProperty([".selector"], "height", "return window.height - 56;");
			"""
		]