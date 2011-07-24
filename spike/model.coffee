class Model
	@property: (prop) ->
		console.log 'setting property', prop

class MyModel extends Model
	@property 'foo'
