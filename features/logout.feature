Feature: Logout from Swag Labs

  As a logged-in user
  I want to be able to logout securely
  So that my session ends and my account stays protected

  Background: User is logged in
    Given I am on the SauceDemo login page
    And I enter username "standard_user"
    And I enter password "secret_sauce"
    And I am logged in

  Scenario: User logs out successfully
    When I open the menu
    And I click the logout button
    Then I should be redirected to the login page

  Scenario: After logout, cannot access protected page
    When I open the menu
    And I click the logout button
    And I try to visit the products page directly
    Then I should be redirected to the login page
