Feature: Save
	As an app developer
	I want a rudimentary way to save an object to the database
	so that I can create an object in the database

	Scenario: Save an already created object
		Given the data mapper is setup
		And a defined model
		When I create an object
		And assign to the object
		And save the ojbect
		Then I can read the object back from the database
