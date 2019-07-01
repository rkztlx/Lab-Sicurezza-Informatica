Feature: USER features
  
  Scenario: As an UNREGISTERED USER I want to DISPLAY THE SIGN IN PAGE
    Given no user exists with an email of "email@person.com"
    When An user go to the "/static_pages/home" page
    And An user click the "Search" button
    Then The user should be to redirect to "/users/sign_in"

