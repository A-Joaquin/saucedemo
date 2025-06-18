Feature: SauceDemo Filtering
  As a shopper
  I want to sort and filter the available products
  So that I can easily find the items I'm interested in

  Background:
    Given I am on the SauceDemo login page

  Scenario: Filter products by Name (A to Z)
    When I enter valid credentials
    And I click the login button
    And I select "Name (A to Z)" from product sort
    Then products should be sorted alphabetically ascending

  Scenario: Filter products by Name (Z to A)
    When I enter valid credentials
    And I click the login button
    And I select "Name (Z to A)" from product sort
    Then the products should be sorted in this order:
      | Test.allTheThings() T-Shirt (Red) |
      | Sauce Labs Onesie                 |
      | Sauce Labs Fleece Jacket         |
      | Sauce Labs Bolt T-Shirt          |
      | Sauce Labs Bike Light            |
      | Sauce Labs Backpack              |

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