mongodb = require 'mongodb'

server = new mongodb.Server 'localhost', mongodb.Connection.DEFAULT_PORT, {}

db = new mongodb.Db 'test', server

db.open()
