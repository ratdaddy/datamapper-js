require 'data_mapper'

describe 'DataMapper.Resource', ->
	describe '#property', ->
		it 'saves the property names', ->
			DataMapper.Resource.property 'testProperty1'
			DataMapper.Resource.property 'testProperty2'
			DataMapper.Resource.properties.should.eql [ 'testProperty1', 'testProperty2' ]

	describe '#new', ->
		it 'returns a model', ->
			DataMapper.Resource.new().should.be.an.instanceof DataMapper.Model

		it 'sets the resource for the model', ->
			DataMapper.Resource.new()._resource.should.equal DataMapper.Resource

describe 'DataMapper.Model', ->
	class TestModel extends DataMapper.Resource
		@property 'testProperty'

	beforeEach ->
		@model = TestModel.new()

	describe ':properties', ->
		it 'returns the list of properties from the resource', ->
			@model.properties.should.eql [ 'testProperty' ]

	describe '#save', ->
		beforeEach ->
			@model.testProperty = 'test value'

			@cb = ->

			spyOn(DataMapper.Inflector, 'tableize').andReturn 'test_coll'

			@collObj =
				insert: ->
			spyOn @collObj, 'insert'

			@collection = ->
			DataMapper.db = @
			spyOn(@, 'collection').andCallFake (name, cb) ->
				cb null, @collObj

			@model.save @cb

		it 'calls tableize on the object name', ->
			expect(DataMapper.Inflector.tableize).toHaveBeenCalledWith 'TestModel'

		it 'calls db.collection with the name of the collection', ->
			@collection.argsForCall[0][0].should.equal 'test_coll'

		it 'calls collection.insert', ->
			expect(@collObj.insert).toHaveBeenCalledWith { testProperty: 'test value' }, @cb
