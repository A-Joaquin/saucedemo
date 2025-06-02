Feature: Login to Swag Labs
  As a potential shopper
  I want to log into Swag Labs
  So that I can view and buy products

  Background: Landing on the login page
    Given I am on the SauceDemo login page

  Scenario: Valid user logs in successfully
    When I enter username "standard_user"
    And  I enter password "secret_sauce"
    And  I click the login button
    Then I should be redirected to the products page

  Scenario: Locked-out user cannot log in
    When I enter username "locked_out_user"
    And  I enter password "secret_sauce"
    And  I click the login button
    Then I should see the error message "Epic sadface: Sorry, this user has been locked out."

  Scenario Outline: Invalid credentials are rejected
  When I enter username "<user>"
  And  I enter password "<pass>"
  And  I click the login button
  Then I should see the error message "<message>"

  Examples:
    | user           | pass        | message                                                                    |
    | invalid_user   | wrong_pass  | Epic sadface: Username and password do not match any user in this service  |
    |                | secret_sauce| Epic sadface: Username is required                                         |
    | standard_user  |             | Epic sadface: Password is required                                         |