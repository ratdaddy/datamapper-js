Feature: Model creation
	As an app developer
	I want a rudimentary way to define my model
	so that I can do CRUD operations on objects of that model

	Scenario: Basic model
		Given A model definition
		When I create an object from that model
		Then I can see the model attributes
