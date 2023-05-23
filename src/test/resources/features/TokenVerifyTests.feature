@Smoke @Regression
Feature: Token verify test 

Background: Set up test URL
	Given url "https://tek-insurance-api.azurewebsites.net"

#Scenario 5
Scenario: Verify valid token  
	And path "/api/token"
	And request {"username": "supervisor","password": "tek_supervisor"}
	When method post
	Then status 200
	And print response
	Given path "/api/token/verify"
	And param token = response.token
	And param username = "supervisor"
	When method get
	Then status 200
	And print response
	And assert response == "true"
	
#Scenario 6
Scenario: Negative test validate token verify with wrong username
	And path "/api/token"
	And request {"username": "supervisor","password": "tek_supervisor"}
	When method post
	Then status 200
	And print response
	Given path "/api/token/verify"
	And param token = response.token
	And param username = "WrongUsername"
	When method get
	Then status 400
	And print response
	And assert response.errorMessage == "Wrong Username send along with Token"
	
	#Scenario 7
	Scenario: Negative test verify token with invalid token and vaild username
		Given path "/api/token/verify"
		And param token = "Invalid_token"
		And param username = "WrongUsername"
		When method get
		Then status 400
		And print response
		And assert response.errorMessage == "Token Expired or Invalid Token"
