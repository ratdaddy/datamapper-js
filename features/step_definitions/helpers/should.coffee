require.paths.push 'node_modules/should/lib'
eql = require 'eql'
sys = require 'sys'

require('should').Assertion.prototype.haveNameValuePair = (obj) ->
	@obj.should.be.an.instanceof Array
	included = false
	for expObj in @obj
		for key of obj
			if obj.hasOwnProperty(key) && eql(obj[key], expObj[key])
				return true
	@assert included, 'expected ' + @inspect + ' to include ' + sys.inspect(obj),
		'expected ' + @inspect + ' to not include ' + sys.inspect(obj)
	@

