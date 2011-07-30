Steps = require('cucumis').Steps

Steps.Given /^the data mapper is setup$/, (ctx) ->
	DataMapper.setup { database: 'test' }, ->
		DataMapper.db.dropDatabase ctx.done

Steps.Given /a defined model$/, (ctx) ->
	require 'test_item'
	ctx.done()

Steps.export module
