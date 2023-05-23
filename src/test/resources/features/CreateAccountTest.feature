@Regression
Feature: Create account test

Background: Set us test URL 
	* def result = callonce read('GenerateToken.feature')
	And print result
	And def generatedToken = result.response.token
	Given url "https://tek-insurance-api.azurewebsites.net"
	
#Scenario 10 (this email already used)
Scenario: Create account test
	Given path "/api/accounts/add-primary-account"
	And header Authorization = "Bearer " + generatedToken
	And request {"email": "aubz349@gmail.com","firstName": "Aubrey","lastName": "Aguilera","title": "Mrs.","gender": "FEMALE","maritalStatus": "MARRIED","employmentStatus": "Employed","dateOfBirth": "1998-08-27"}
	When method post
	Then status 201
	And print response
	And assert response.email == "aubz349@gmail.com"
	Given path "/api/accounts/delete-account"
	And header Authorization = "Bearer " + generatedToken
	And param primaryPersonId = response.id
	When method delete
	Then status 200
	And print response
	And assert response == "Account Successfully deleted"
	
	