mongodb = require 'mongodb'

class DataMapper
	@setup: (options, cb) ->
		if typeof options ==  'function'
			cb = options
			hostname = 'localhost'
			port = mongodb.Connection.DEFAULT_PORT
		else
			hostname = options.hostname || 'localhost'
			port = options.port || mongodb.Connection.DEFAULT_PORT

		@_initDB hostname, port
		@db.open cb

	@_initDB: (hostname, port) ->
		server = new mongodb.Server hostname, port, {}
		@db = new mongodb.Db 'test', server

global.DataMapper = DataMapper
