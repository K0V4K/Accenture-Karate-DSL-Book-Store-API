@ignore
Feature: Autenticação Base

  Scenario: Criar Usuário e Gerar Token
    * url baseUrl

    Given path 'Account/v1/User'
    And request { userName: '#(authUserName)', password: '#(authPassword)' }
    When method post
    Then status 201
    * def userId = response.userID

    Given path 'Account/v1/GenerateToken'
    And request { userName: '#(authUserName)', password: '#(authPassword)' }
    When method post
    Then status 200
    * def authToken = response.token