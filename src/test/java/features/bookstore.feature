Feature: Operações da Livraria

  Background:
    * url baseUrl
    * def auth = call read('../helpers/auth.feature')
    * def token = auth.authToken
    * def userId = auth.userId

  Scenario: Gerenciar livros no perfil com sucesso
    Given path 'BookStore/v1/Books'
    When method get
    Then status 200
    And match each response.books == { isbn: '#string', title: '#string', subTitle: '#string', author: '#string', publish_date: '#string', publisher: '#string', pages: '#number', description: '#string', website: '#string' }

    * def isbn1 = response.books[0].isbn
    * def isbn2 = response.books[1].isbn

    Given path 'BookStore/v1/Books'
    And header Authorization = 'Bearer ' + token
    And request { userId: '#(userId)', collectionOfIsbns: [{ isbn: '#(isbn1)' }] }
    When method post
    Then status 201
    Given path 'BookStore/v1/Books', isbn1
    And header Authorization = 'Bearer ' + token
    And request { userId: '#(userId)', isbn: '#(isbn2)' }
    When method put
    Then status 200
    And match response.books[0].isbn == isbn2

  Scenario Outline: Validar busca de livro por ISBN
    Given path 'BookStore/v1/Book'
    And param ISBN = '<isbn_input>'
    When method get
    Then status <status_esperado>

    Examples:
      | isbn_input    | status_esperado |
      | 9781449325862 | 200             |
      | 1234567890    | 400             |