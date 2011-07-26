class Base
	properties: []

	@new: ->
		obj = {}
		obj._base = new @
		obj

class Child extends Base

child = Child.new()

console.log child._base.properties
