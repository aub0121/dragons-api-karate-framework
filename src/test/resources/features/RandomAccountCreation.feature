@Regression
Feature: Random account creation 

Background: Setup test generate token 
	* def tokenFeature = callonce read('GenerateToken.feature')
	* def token = tokenFeature.response.token
	Given url "https://tek-insurance-api.azurewebsites.net"
	
Scenario: Create accont with random email
	#Call java class and menthod with Karate
	* def dataGenerator = Java.type('api.data.GenerateData')
	* def autoEmail = dataGenerator.getEmail()
	Given path "/api/accounts/add-primary-account"
	And header Authorization = "Bearer " + token
	And request 
	"""
	{
	"email": "#(autoEmail)",
	"firstName": "Aubrey",
	"lastName": "Aguilera",
	"title": "Mrs.",
	"gender": "FEMALE",
	"maritalStatus": "MARRIED",
	"employmentStatus": "Employed",
	"dateOfBirth": "1998-08-27"
	}
	"""
	When method post
	Then status 201
	And print response
	And assert response.email == autoEmail
	