require 'data_mapper'

describe 'DataMapper.Inflector', ->
	describe '#tableize', ->
		it 'underscores and pluralizes', ->
			DataMapper.Inflector.tableize('testItem').should.equal 'test_items'
