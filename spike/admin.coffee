mongodb = require 'mongodb'

server = new mongodb.Server 'localhost', mongodb.Connection.DEFAULT_PORT, {}

db = new mongodb.Db 'test', server

db.open (err, db) ->
	db.admin (err, admin) ->
		admin.serverInfo (err, doc) ->
			console.log err
			console.log doc
			db.close()
