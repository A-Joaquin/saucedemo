Feature: SauceDemo Testing

  Background:
    Given I am on the SauceDemo login page

  Scenario: Successful login with standard user
    When I enter valid credentials
    And I click the login button
    Then I should see the inventory page

  Scenario: Failed login with invalid credentials
    When I enter username "usuarioinvalido" and password "equivocado"
    And I click the login button
    Then I should see error message "Epic sadface: Username and password do not match any user in this service"

  Scenario: Failed login with locked user
    When I enter username "locked_out_user" and password "secret_sauce"
    And I click the login button
    Then I should see error message "Epic sadface: Sorry, this user has been locked out."

  Scenario: Add single item to cart
  When I enter valid credentials
  And I click the login button
  And I add "Sauce Labs Backpack" to cart
  Then the cart badge should show "1"
  And the item should be in the cart

  Scenario: Filter products by Name (A to Z)
    When I enter valid credentials
    And I click the login button
    And I select "Name (A to Z)" from product sort
    Then products should be sorted alphabetically ascending

  Scenario: Filter products by Name (Z to A)
    When I enter valid credentials
    And I click the login button
    And I select "Name (Z to A)" from product sort
    Then products should be sorted alphabetically descending

  Scenario: Filter products by Price (low to high)
    When I enter valid credentials
    And I click the login button
    And I select "Price (low to high)" from product sort
    Then products should be sorted by price ascending

  Scenario: Filter products by Price (high to low)
    When I enter valid credentials
    And I click the login button
    And I select "Price (high to low)" from product sort
    Then products should be sorted by price descending