require 'data_mapper'

MONGO_DEFAULT_PORT = require('mongodb').Connection.DEFAULT_PORT

describe 'DataMapper', ->
	describe '#setup', ->
		beforeEach ->
			@db = open: ->
			spyOn @db, 'open'

			@cb = ->

			spyOn(DataMapper, '_initDB').andCallFake =>
				DataMapper.db = @db

		context 'default parameters', ->
			beforeEach ->
				DataMapper.setup @cb

			it 'initializes the database object with the default host', ->
				expect(DataMapper._initDB).toHaveBeenCalledWith 'localhost', MONGO_DEFAULT_PORT

			it 'calls db.open with the callback', ->
				expect(@db.open).toHaveBeenCalledWith(@cb)

		context 'hostname specified', ->
			beforeEach ->
				DataMapper.setup { hostname: 'hostname' }, @cb

			it 'calls initDB with the hostname', ->
				expect(DataMapper._initDB).toHaveBeenCalledWith 'hostname', MONGO_DEFAULT_PORT

			it 'calls db.open with the callback', ->
				expect(@db.open).toHaveBeenCalledWith(@cb)

		context 'port number specified', ->
			beforeEach ->
				DataMapper.setup { port: 3000 }, @cb

			it 'calls initDB with the default hostname and specified port number', ->
				expect(DataMapper._initDB).toHaveBeenCalledWith 'localhost', 3000

			it 'calls db.open with the callback', ->
				expect(@db.open).toHaveBeenCalledWith(@cb)

	describe '#_initDB', ->
		# This is not tested since it encapsulates non-algorithmic low-level DB setup
