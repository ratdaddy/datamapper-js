Steps = require('cucumis').Steps

collection = null

Steps.Given /^there are several documents in the database$/, (ctx) ->
	DataMapper.db.collection 'test_items', (err, collection) ->
		collection.insert { key: 'value1' }, ->
			collection.insert { key: 'value2' }, ->
				collection.insert {  key: 'value3' }, ctx.done

Steps.When /^I do an all query with no parameters$/, (ctx) ->
	TestItem.all (err, coll) ->
		collection = coll
		ctx.done()

Steps.Then /^I get a collection with all the documents in the database$/, (ctx) ->
	collection.should.have.length 3
	collection.should.haveNameValuePair key: 'value1'
	collection.should.haveNameValuePair key: 'value2'
	collection.should.haveNameValuePair key: 'value3'
	DataMapper.db.close()
	ctx.done()
	
Steps.When /^I do an all query with a key-value pair$/, (ctx) ->
	TestItem.all { key: 'value2' }, (err, coll) ->
		collection = coll
		ctx.done()

Steps.Then /^I get a collection with only the specified documents$/, (ctx) ->
	collection.should.have.length 1
	collection.should.haveNameValuePair key: 'value2'
	DataMapper.db.close()
	ctx.done()

Steps.export module
