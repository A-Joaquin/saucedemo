Feature: Checkout Process with Specific Products
  As a shopper
  I want to buy specific products in my cart
  So I can complete my purchase with the exact items I want

  Background: 
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And I enter password "secret_sauce"
    And I click the login button
    Then I should be redirected to the products page

  @checkout @smoke @login_required
  Scenario: Successful checkout with first product
    When I add the first product "Sauce Labs Backpack" to the cart
    And I proceed to checkout
    And I fill checkout information with first name "Juan", last name "Pérez", and postal code "12345"
    And I continue to checkout overview
    Then I should see "Sauce Labs Backpack" in the checkout summary
    And I should see the subtotal "$29.99" for 1 item
    When I complete the purchase
    Then I should see the order confirmation "Thank you for your order!"

  @checkout @login_required
  Scenario: Successful checkout with last product
    When I add the last product "Test.allTheThings() T-Shirt (Red)" to the cart
    And I proceed to checkout
    And I fill checkout information with first name "Maria", last name "García", and postal code "54321"
    And I continue to checkout overview
    Then I should see "Test.allTheThings() T-Shirt (Red)" in the checkout summary
    And I should see the subtotal "$15.99" for 1 item
    When I complete the purchase
    Then I should see the order confirmation "Thank you for your order!"

  @checkout @login_required
  Scenario: Checkout with multiple specific products
    When I add the first product "Sauce Labs Backpack" to the cart
    And I add the product "Sauce Labs Bike Light" to the cart
    And I add the last product "Test.allTheThings() T-Shirt (Red)" to the cart
    And I proceed to checkout
    And I fill checkout information with first name "Carlos", last name "Ruiz", and postal code "67890"
    And I continue to checkout overview
    Then I should see all 3 products in the checkout summary:
      | Sauce Labs Backpack                    |
      | Sauce Labs Bike Light                  |
      | Test.allTheThings() T-Shirt (Red)      |
    And the calculated subtotal should match the sum of individual prices
    When I complete the purchase
    Then I should see the order confirmation "Thank you for your order!"

  @checkout @validation
  Scenario Outline: Checkout validation with specific product
    Given I have added "Sauce Labs Backpack" to the cart
    When I proceed to checkout
    And I fill checkout information with first name "<first_name>", last name "<last_name>", and postal code "<postal_code>"
    And I attempt to continue to checkout overview
    Then I should see the validation error "<error_message>"
    And I should remain on the checkout information page

    Examples:
      | first_name | last_name | postal_code | error_message                      |
      |            | Pérez     | 12345       | Error: First Name is required      |
      | Juan       |           | 12345       | Error: Last Name is required       |
      | Juan       | Pérez     |             | Error: Postal Code is required     |

  @checkout @cancellation
  Scenario: Cancel checkout and verify cart preservation
    When I add the first product "Sauce Labs Backpack" to the cart
    And I add the last product "Test.allTheThings() T-Shirt (Red)" to the cart
    And I proceed to checkout
    And I fill checkout information with first name "Ana", last name "López", and postal code "11111"
    And I continue to checkout overview
    And I cancel the checkout process
    Then I should be redirected to the products page
    And the cart should still contain 2 items
    And the cart should contain "Sauce Labs Backpack"
    And the cart should contain "Test.allTheThings() T-Shirt (Red)"