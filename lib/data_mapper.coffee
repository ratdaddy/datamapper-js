mongodb = require 'mongodb'
inflect = require 'inflect'

class DataMapper
	@setup: (options, cb) ->
		if options.database?
			hostname = options.hostname || 'localhost'
			port = options.port || mongodb.Connection.DEFAULT_PORT
			database = options.database

			@_initDB hostname, port, database
			@db.open cb
		else
			cb new Error('Must specify a database name to setup')

	@_initDB: (hostname, port, database) ->
		server = new mongodb.Server hostname, port, {}
		@db = new mongodb.Db database, server

class DataMapper.Model
	constructor: ->
		@__defineGetter__ 'properties', ->
			@_resource.properties

	save: (cb) ->
		collName = DataMapper.Inflector.tableize @_resource.name
		DataMapper.db.collection collName, (err, collection) =>
			saveObj = {}
			for property in @properties
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

	@all: (cb) ->
		collName = DataMapper.Inflector.tableize @name
		DataMapper.db.collection collName, (err, collection) ->
			collection.find (err, cursor) ->
				cursor.toArray cb

class DataMapper.Inflector
	@tableize: (className) ->
		inflect.underscore inflect.pluralize(className)

global.DataMapper = DataMapper
