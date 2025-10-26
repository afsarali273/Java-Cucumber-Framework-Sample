@UI
Feature: Web UI Testing Example
  Sample UI tests using framework step definitions

  Scenario: Search on Google
    Given open browser
    And navigate to "https://www.google.com"
    When type "Selenium automation" into "textarea[name='q']"
    And press enter on element "textarea[name='q']"
    And wait for page load
    Then page should contain text "results"

  Scenario: Verify page elements
    Given open browser
    And navigate to "https://example.com"
    Then element "h1" should be visible
    And element "h1" text should be "Example Domain"
    And page title should contain "Example"
    When save text of "h1" as "pageHeading"
    Then saved variable "pageHeading" should be "Example Domain"
    When close browser
