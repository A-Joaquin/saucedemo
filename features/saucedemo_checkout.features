Feature: Checkout process

  As a shopper
  I want to buy the products in my cart
  So I can complete my purchase and receive my order

  Background: Login and add a product to the cart
    Given I am on the SauceDemo login page
    When I enter username "standard_user"
    And  I enter password "secret_sauce"
    And  I click the login button
    Then I should be redirected to the products page
    When I add the first product to the cart

  Scenario: Successful checkout with valid data
    When I go to the cart
    And I click the checkout button
    And I fill in my information with first name "Juan", last name "Pérez", and postal code "12345"
    And I continue to the overview
    And I finish the purchase
    Then I should see the confirmation message "Thank you for your order!"

  Scenario: Checkout fails with empty fields
    When I go to the cart
    And I click the checkout button
    And I continue to the overview
    Then I should see the error message "Error: First Name is required"

  Scenario: Cancel checkout and return to products
    When I go to the cart
    And I click the checkout button
    And I fill in my information with first name "Juan", last name "Pérez", and postal code "12345"
    And I continue to the overview
    And I cancel the purchase
    Then I should be redirected to the products page

  Scenario Outline: Validation of required fields at checkout
    When I go to the cart
    And I click the checkout button
    And I fill in my information with first name "<nombre>", last name "<apellido>", and postal code "<codigo_postal>"
    And I continue to the overview
    Then I should see the error message "<mensaje>"

    Examples:
      | nombre | apellido | codigo_postal | mensaje                        |
      |        | Pérez    | 12345         | Error: First Name is required  |
      | Juan   |          | 12345         | Error: Last Name is required   |
      | Juan   | Pérez    |               | Error: Postal Code is required |

Scenario: Cancel on the information screen and return to the cart
  When I go to the cart
  And I click the checkout button
  And I cancel the information entry
  Then I should be redirected to the cart page

Scenario: Cancel on the summary screen and return to the catalog
  When I go to the cart
  And I click the checkout button
  And I fill in my information with first name "Maria", last name "Gomez", and postal code "10101"
  And I continue to the overview
  And I cancel the purchase
  Then I should be redirected to the products page

Scenario: Validate subtotal on the summary screen with two products
    And I add the second product to the cart
    And I go to the cart
    And I click the checkout button
    And I fill in my information with first name "Carlos", last name "Ruiz", and postal code "55555"
    And I continue to the overview
    Then the total should be correct

Scenario: Attempt to checkout with an empty cart
    When I go to the cart
    And I remove all items from the cart
    And I click the checkout button
    Then I should be on the checkout information page

Scenario: Modify checkout information after navigating back from overview
    When I go to the cart
    And I click the checkout button
    And I fill in my information with first name "Original", last name "User", and postal code "10001"
    And I continue to the overview
    Then I should be on the checkout overview page
    When I navigate back to the previous page
    Then I should be on the checkout information page
    And I fill in my information with first name "Changed", last name "Name", and postal code "20002"
    And I continue to the overview
    Then I should be on the checkout overview page
    And I finish the purchase
    Then I should see the confirmation message "Thank you for your order!"