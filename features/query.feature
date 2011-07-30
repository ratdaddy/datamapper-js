Feature: Basic query
	As an app developer
	I want a simple way to query the database
	so that I can receive a collection of documents I'm interested in

	Scenario: Find a set of records
		Given the data mapper is setup
		And there are several documents in the database
		And a defined model
		When I do an all query with no parameters
		Then I get a collection with all the documents in the database
