Feature: End to end account testing

Background: API test setup
	* def result = callonce read("GenerateToken.feature")
	And print result
	* def generatedToken = result.response.token
	Given url "https://tek-insurance-api.azurewebsites.net"
	

Scenario: End-to-End account creation testing
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
	
