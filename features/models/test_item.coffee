require 'data_mapper'

class TestItem extends DataMapper.Resource
	@property 'testAttr1'

global.TestItem = TestItem
