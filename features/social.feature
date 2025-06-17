Feature: SauceDemo Social Media Links

  Background:
    Given I am on the SauceDemo login page
    When I enter valid credentials
    And I click the login button
    And I scroll to the footer

  Scenario: Navigate to Facebook page
    Given I can see the social media icons
    When I click on the Facebook icon
    Then a new tab should open
    And the Facebook URL should be "https://www.facebook.com/saucelabs"
    And the Facebook page title should contain "Sauce Labs"