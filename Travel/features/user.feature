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
    Given A registered user as "email@user.com","password"
    When An user click the "Log Out"
    Then An user should see the "Sign In"

  Scenario: As a USER I want to HAVE USER SETTINGS so that I can UPDATE MY USER PROFILE
    Given A registered user as "email@user.com","password"
    When An "email@user.com" go to the user+id page
    And An user should see the "Edit Info"
    When An user go to the "/users/edit" page
    Then An user should see the "Update my Profile"
    
    
  Scenario: As a USER I want to HAVE A USER PROFILE so that I can SEE MY FAVORITE PLACE
    Given A registered user as "email@user.com","password"
    When An "email@user.com" go to the user+id page
    Then An user should see the "Favorite Place"

  Scenario: As a USER I want to ADD REVIEWS TO PLACES so that ANOTHER USERS CAN SEE my REVIEWS
    Given A registered user as "email@user.com","password" 
    When An "email@user.com" go to the user+id page

  Scenario: As a USER I want to ADD LIKE to review so that the like count increase

  Scenario: As a USER I want to ADD DISLIKE to review so that the dislike count increase
  
  Scenario: As a USER I want to SEE all REVIEWS made by me so that I CAN MODIFY them.

  Scenario: As a USER I want to INSERT a PLACE so that it CAN BE FOUND and REVIEWED by other USERS and that I am REGISTERED as the OWNER
    Given A registered user as "email@user.com","password"
    When An user go to the "/places/new" page
    And The user create the place as "Name","Street",1,"City"
    Then The user should be redirected to "/static_pages/home" page
    
  Scenario: As a USER I want to SEARCH for a PLACE by the NAME and MY POSITION so I can SEE it
    Given A registered user as "email@user.com","password"
    Given "Place1","Via Prova",1,"Rome" place exist 
    When An user go to the "/static_pages/home" page
    When An user search for "Place1" place
    Then An user should see the "Place1"
    
    
