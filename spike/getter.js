function SomeObj() {
	//SomeObj.foo = 'bar';
	var foo;
	return {
		get foo() {
			return 'bar'
		}
	};
}

SomeObj.__defineGetter__('properties', function() {
		return [ 'foo' ];
});

someObj = new SomeObj();

console.log(someObj);
console.log(someObj.foo);
