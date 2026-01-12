Feature: Gestão de Conta

  Background:
    * url baseUrl
    * def auth = call read('../helpers/auth.feature')
    * def token = auth.authToken
    * def userId = auth.userId

  Scenario: Validar exclusão de usuário com sucesso
    Given path 'Account/v1/User', userId
    And header Authorization = 'Bearer ' + token
    When method delete
    Then status 204

  Scenario: Tentar deletar usuário sem autorização (Falha)
    Given path 'Account/v1/User', userId
    When method delete
    Then status 401