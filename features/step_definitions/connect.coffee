Steps = require('cucumis').Steps

error = null
checkedRunning = false

Steps.Given /^a running mongo daemon$/, (ctx) ->
	unless checkedRunning
		require('child_process').exec 'mongo --eval "version()"', (error, stdout) ->
			stdout.should.match /\nversion:/
			checkedRunning = true
			ctx.done()
	else
		ctx.done()

Steps.When /^I create a connection$/, (ctx) ->
	require 'data_mapper'
	DataMapper.setup { database: 'test_db' }, ctx.done

Steps.Then /^I can execute a mongo command on the connection$/, (ctx) ->
	DataMapper.db.admin (err, admin) ->
		admin.serverInfo (err, doc) ->
			doc.ok.should.equal 1
			DataMapper.db.close()
			ctx.done()

Steps.When /^I create a connection giving an invalid hostname$/, (ctx) ->
	DataMapper.setup { hostname: 'invalid', database: 'test_db' }, (err) ->
		error = err
		ctx.done()

Steps.When /^I create a connection giving an invalid port number$/, (ctx) ->
	DataMapper.setup { port: 3000, database: 'test_db' }, (err) ->
		error = err
		ctx.done()

Steps.When /^I create a connection with no database name$/, (ctx) ->
	DataMapper.setup {}, (err) ->
		error = err
		ctx.done()

Steps.Then /^I get a connection error$/, (ctx) ->
		error.should.be.an.instanceof Error
		ctx.done()

Steps.export module
