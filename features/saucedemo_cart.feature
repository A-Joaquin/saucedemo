Feature: Shopping Cart Functionality
  As a logged in user
  I want to add and remove items from my cart
  So that I can manage my purchases

  Background:
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And I enter password "secret_sauce"
    And I click the login button

  Scenario: Add item to cart
    When I click on the add to cart button for "Sauce Labs Backpack"
    Then the cart badge should show "1"
    And the button should change to "Remove"

  Scenario: Remove item from cart
    Given I have added "Sauce Labs Backpack" to the cart
    When I click the remove button
    Then the cart badge should be empty
    And the button should change to "Add to cart"

  Scenario: View cart details
    When I click on the cart title "Sauce Labs Backpack"
    Then I should see the cart details page for "Sauce Labs Backpack"
    And I should see detailed cart information