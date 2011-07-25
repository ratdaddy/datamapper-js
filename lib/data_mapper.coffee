mongodb = require 'mongodb'
_ = require 'underscore'

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

class DataMapper.Model
	constructor: ->
		@__defineGetter__ 'properties', ->
			@_resource.properties

	save: (cb) ->
		DataMapper.db.collection 'test_coll', (err, collection) =>
			saveObj = {}
			_.each @properties, (property) =>
				saveObj[property] = @[property] if @[property]?

			collection.insert saveObj, cb

class DataMapper.Resource
	@properties: []

	@property: (name) ->
		@properties.push name

	@new: ->
		model = new DataMapper.Model
		model._resource = @
		model

global.DataMapper = DataMapper
