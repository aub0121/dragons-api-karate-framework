Feature: home work 

Background: Set up test URL 
	Given url "https://tek-insurance-api.azurewebsites.net" 

	Scenario: Get account API call with existing account
	Given path "/api/token"
	And request {"username": "supervisor","password": "tek_supervisor"}
	When method post
	Then status 200
	And print response
	# def is a step definition to define new variable in karate framework
	* def generatedToken = response.token
	Given path "/api/accounts/get-account"
	And param primaryPersonId = 6804
	And header Authorization = "Bearer " + generatedToken
	When method get
	Then status 200
	And print response
	And assert response.primaryPerson.id == 6804
	And assert response.primaryPerson.email == "flowerz12345@gmail.com"
	