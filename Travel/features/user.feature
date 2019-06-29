Feature: USER features
  
  Scenario: As an UNREGISTERED USER I want to SIGN UP WITH EMAIL
    Given no user exists with an email of "email@user.com"
    When An user go to the "/users/sign_up" page
    And The user sign in as "email@user.com", "password","password","pippo","franco","pippo1"
    Then The user should be to redirect to "/static_pages/home"

