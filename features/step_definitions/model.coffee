Steps = require('cucumis').Steps

require 'data_mapper'

TestModel = null
testModel = null

Steps.Given /^A model definition$/, (ctx) ->
	class TestModel extends DataMapper.Resource
		@property 'testProperty'

	ctx.done()

Steps.When /^I create an object from that model$/, (ctx) ->
	testModel = TestModel.new()
	ctx.done()

Steps.Then /^I can see the model attributes$/, (ctx) ->
	testModel.properties.should.eql [ 'testProperty' ]
	ctx.done()

Steps.export module

