Feature: Connect
	As an app developer
	I want a way to connect to my mongo database
	so that subsequent database operations are performed on that connection

	Scenario: Simple connection
		Given a running mongo daemon
		When I create a connection
		Then I can execute a mongo command on the connection

	Scenario: Specified hostname and an error
		Given a running mongo daemon
		When I create a connection giving an invalid hostname
		Then I get a connection error

	Scenario: Specified hostname and an error
		Given a running mongo daemon
		When I create a connection giving an invalid port number
		Then I get a connection error
