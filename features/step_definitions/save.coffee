Steps = require('cucumis').Steps

require 'data_mapper'

TestItem = null
testObject = null

Steps.Given /^the data mapper is setup$/, (ctx) ->
	DataMapper.setup { database: 'test' }, ->
		DataMapper.db.dropDatabase ctx.done

Steps.Given /a defined model$/, (ctx) ->
	class TestItem extends DataMapper.Resource
		@property 'testAttr1'

	ctx.done()

Steps.When /^I create an object$/, (ctx) ->
	testObject = TestItem.new()
	ctx.done()

Steps.When /^assign to the object$/, (ctx) ->
	testObject.testAttr1 = 'test value 1'
	testObject.testAttr2 = 'test value 2'
	ctx.done()

Steps.When /^save the ojbect$/, (ctx) ->
	testObject.save ctx.done

Steps.Then /^I can read the object back from the database$/, (ctx) ->
	db = DataMapper.db
	db.collection 'test_items', (err, collection) ->
		collection.find().toArray (err, results) ->
			results.length.should.equal 1
			results[0].testAttr1.should.equal 'test value 1'
			results[0].should.not.include.keys 'testAttr2'
			db.close()
			ctx.done()

Steps.export module
