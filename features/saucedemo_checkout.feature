Feature: Checkout functionality

  Background:
    Given I am on the SauceDemo login page
    When I enter valid credentials
    And I click the login button
    And I add "Sauce Labs Backpack" to cart
    And I go to cart

  Scenario: Complete checkout with valid information
    When I click the checkout button
    And I enter checkout information with first name "Juan", last name "Perez" and postal code "12345"
    And I click the continue button
    And I click the finish button
    Then I should see the checkout complete page
    And I should see "Thank you for your order" message

  Scenario: Checkout with missing information
    When I click the checkout button
    And I enter checkout information with first name "", last name "Perez" and postal code "12345"
    And I click the continue button
    Then I should see error message "Error: First Name is required"

  Scenario: Return to cart from checkout
    When I click the checkout button
    And I click the cancel button
    Then I should be back at the cart page

  Scenario: View checkout summary and item total
    When I click the checkout button
    And I enter checkout information with first name "Juan", last name "Perez" and postal code "12345"
    And I click the continue button
    Then I should see the checkout summary page
    And The item total should match the sum of item prices