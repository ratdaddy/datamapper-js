require 'data_mapper'

describe 'DataMapper.Resource', ->
	class TestModel extends DataMapper.Resource

	describe '#all', ->
		beforeEach ->
			@cb = ->

			@cursor =
				toArray: ->
			spyOn @cursor, 'toArray'

			@collObj =
				find: ->
			spyOn(@collObj, 'find').andCallFake (cb) =>
				cb null, @cursor

			@collection = ->
			DataMapper.db = @
			spyOn(@, 'collection').andCallFake (name, cb) ->
				cb null, @collObj

			spyOn(DataMapper.Inflector, 'tableize').andCallThrough()

			TestModel.all @cb

		it 'calls tableize on the model name', ->
			expect(DataMapper.Inflector.tableize).toHaveBeenCalledWith 'TestModel'

		it 'calls db.collection with the name of the collection', ->
			@collection.argsForCall[0][0].should.equal 'test_models'

		it 'calls collection.find', ->
			expect(@collObj.find).toHaveBeenCalled()

		it 'converts the cursor to an array', ->
			expect(@cursor.toArray).toHaveBeenCalledWith @cb
