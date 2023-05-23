Feature: End to end account testing
	
  Background: API test setup
    * def result = callonce read('GenerateToken.feature')
    And print result
    * def generatedToken = result.response.token
    Given url "https://tek-insurance-api.azurewebsites.net"

  Scenario:  End to end account testing
    * def dataGenerator = Java.type('api.data.GenerateData')
    * def emailAddressData = dataGenerator.getEmail()
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "email": "#(emailAddressData)",
      "firstName": "Aubrey",
      "lastName": "Ruiz",
      "title": "Mrs.",
      "gender": "FEMALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "EMPLOYED",
      "dateOfBirth": "1998-08-27"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == emailAddressData
    And assert response.firstName == "Aubrey"
    * def generatedAccountId = response.id
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    And request
      """
      {
      "addressType": "Home",
      "addressLine1": "123 Hello St",
      "city": "Harrisonburg",
      "state": "Virginia",
      "postalCode": "22801",
      "countryCode": "",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.addressLine1 == "123 Hello St"
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    * def randomPhoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
      "phoneNumber": "#(randomPhoneNumber)",
      "phoneExtension": "",
      "phoneTime": "Morning",
      "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.phoneNumber == randomPhoneNumber
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    * def randomLicensePlate = dataGenerator.getLicensePlate()
    And request
      """
      {
      "make": "GMC",
      "model": "Terrain",
      "year": "2020",
      "licensePlate": "#(randomLicensePlate)"
      }
      """
    When method post
    And status 201
    And print response
    And assert response.licensePlate == randomLicensePlate
    Given path "/api/accounts/get-account"
    And param primaryPersonId = generatedAccountId
    And header Authorization = "Bearer " + generatedToken
    When method get
    Then status 200
    And print response
    And assert response.primaryPerson.id == generatedAccountId