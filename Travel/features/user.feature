Feature: USER features
  
  Scenario: As an UNREGISTERED USER I want to DISPLAY THE SIGN IN PAGE
    Given no user exists with an email of "email@user.com"
    When An user go to the "/static_pages/home" page
    And An user click the "Search" button
    Then The user should be redirected to "/users/sign_in" page

  Scenario: As an UNREGISTERED USER I want to SIGN UP WITH EMAIL
    Given no user exists with an email of "email@user.com"
    When An user go to the "/users/sign_up" page
    And The user sign up as "email@user.com","password","pippo","franco","pippo1"
    Then The user should be redirected to "/users" page
    
  Scenario: As a USER I want to SIGN IN WITH E-MAIL
    Given An User is signed up and confirmed as "email@user.com","password","pippo","franco","pippo1"  
    When An user go to the "/users/sign_in" page
    And The user sign in as "email@user.com","password"
    Then The user should be redirected to "/static_pages/home" page
    
  Scenario: As a USER I want to LOGOUT so I can LOG IN with another account
    Given A registered user as "email@user.com"
    When An user go to the "/users/sign_out" page
    Then An user should see the "Log In" button
