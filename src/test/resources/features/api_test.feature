@API
Feature: REST API Testing Example
  Sample API tests using framework step definitions

  Scenario: Get user details
    When user sends GET request to "/users/1"
    Then response status code should be 200
    And response should contain "id" field
    And response should contain "name" field
    And json path "id" should be "1"
    And json path "name" should not be null
    And response time should be less than 3000 ms

  Scenario: Create and verify user
    When user sets request body:
      """
      {
        "name": "John Doe",
        "email": "john@example.com",
        "username": "johndoe"
      }
      """
    And user sends POST request to "/users"
    Then response status code should be 201
    And json path "name" should be "John Doe"
    And json path "email" should be "john@example.com"
    When user saves json path "id" as "userId"
    Then saved variable "userId" should not be null

  Scenario: Get all users and validate
    When user sends GET request to "/users"
    Then response status code should be 200
    And json array "$" should have size 10
    And at least one element in json array "$" should have "id" equal "1"
    And response content type should be "application/json; charset=utf-8"
