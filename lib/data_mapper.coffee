mongodb = require 'mongodb'
_ = require 'underscore'
inflect = require 'inflect'

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
		collName = DataMapper.Inflector.tableize @_resource.name
		DataMapper.db.collection collName, (err, collection) =>
			saveObj = {}
			_.each @properties, (property) =>
				saveObj[property] = @[property] if @[property]?

			collection.insert saveObj, cb

class DataMapper.Resource
	@property: (name) ->
		@properties = [] unless @properties?
		@properties.push name

	@new: ->
		model = new DataMapper.Model
		model._resource = @
		model

class DataMapper.Inflector
	@tableize: (className) ->
		inflect.underscore inflect.pluralize(className)

global.DataMapper = DataMapper
