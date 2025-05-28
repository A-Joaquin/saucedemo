Feature: Login functionality

  Scenario: Successful login with standard user
    Given I am on the SauceDemo login page
    When I enter valid credentials
    And I click the login button
    Then I should see the inventory page
