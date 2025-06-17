Feature: Shopping Cart Functionality
  As a logged in user
  I want to add and remove items from my cart
  So that I can manage my purchases

  Background:
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And I enter password "secret_sauce"
    And I click the login button
    Then I should be redirected to the products page

  @cart @smoke
  Scenario: Add first product to cart
    When I add the first product "Sauce Labs Backpack" to the cart
    Then the cart badge should show "1"
    And the button for "Sauce Labs Backpack" should change to "Remove"
    And the first product should remain "Sauce Labs Backpack"

  @cart
  Scenario: Add last product to cart
    When I add the last product "Test.allTheThings() T-Shirt (Red)" to the cart
    Then the cart badge should show "1"
    And the button for "Test.allTheThings() T-Shirt (Red)" should change to "Remove"
    And the last product should remain "Test.allTheThings() T-Shirt (Red)"

  @cart
  Scenario: Add multiple specific products to cart
    When I add the first product "Sauce Labs Backpack" to the cart
    And I add the product "Sauce Labs Bike Light" to the cart
    And I add the last product "Test.allTheThings() T-Shirt (Red)" to the cart
    Then the cart badge should show "3"
    And all selected products should have "Remove" buttons

  @cart @cleanup_required
  Scenario: Remove specific product from cart
    Given I have added "Sauce Labs Backpack" to the cart
    And I have added "Sauce Labs Bike Light" to the cart
    When I remove "Sauce Labs Backpack" from the cart
    Then the cart badge should show "1"
    And the button for "Sauce Labs Backpack" should change to "Add to cart"
    And the button for "Sauce Labs Bike Light" should remain "Remove"

  @cart @navigation
  Scenario: View cart details for specific product
    Given I have added "Sauce Labs Backpack" to the cart
    When I click on the cart link
    And I click on the product title "Sauce Labs Backpack" in cart
    Then I should see the product details page for "Sauce Labs Backpack"
    And I should see the product price "$29.99"
    And I should see the product description contains "pack"