Feature: API Test Security Section 


Background:
	Given url "https://tek-insurance-api.azurewebsites.net" 
	And path "/api/token"

Scenario: Create token with valid username and password. 
	#prepare request in background
	And request {"username": "supervisor","password": "tek_supervisor"}
	#Send request 
	When method post 
	#Validating response
	Then status 200 
	And print response

#Scenario 1	
Scenario: Validate token with invalid username	
	And request {"username": "super","password": "tek_supervisor"}
	When method post
	Then status 400
	And print response
	And assert response.errorMessage == "User not found"
	
#Scenario 2	
Scenario: Validate token with invalid password	
	And request {"username": "supervisor","password": "tek"}
	When method post
	Then status 400
	And print response
	And assert response.errorMessage == "Password Not Matched"
	And assert response.httpStatus == "BAD_REQUEST"
	And assert response.errorCode == "WRONG_PASSWORD"