Feature: Get all plan user story

Background: API test setup
	* def result = callonce read("GenerateToken.feature")
	And print result
	* def generatedToken = result.response.token
	Given url "https://tek-insurance-api.azurewebsites.net"
	
Scenario: Get all plan
	Given url "https://tek-insurance-api.azurewebsites.net"
	Given path "/api/plans/get-all-plan-code"
	And header authorization = "Bearer " + generatedToken
	When method get
	Then status 200
	And print response