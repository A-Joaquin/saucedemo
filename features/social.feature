Feature: SauceDemo Social Media Links
  As a user
  I want to access the company's social media profiles
  So that I can follow their updates and connect with the community

  Background: User is on the social media section
    Given I am on the SauceDemo login page
    And I enter valid credentials
    And I am logged in
    And I scroll to the footer

  Scenario: Navigate to Facebook page
    Given I can see the social media icons
    When I click on the Facebook icon
    Then a new tab should open
    And the social media link should match:
      | platform | url                               | title       |
      | Facebook | https://www.facebook.com/saucelabs | Sauce Labs |