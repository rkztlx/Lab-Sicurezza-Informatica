Feature: User can manually add place
 
Scenario: Add a place
  When An user go to the "/places/find" page
  When An user click on "Register Place"
  Then I should be on the Create New Place page
  When I fill in "Name" with "Sorbillo"
  And I fill in "Street" with "Via Dei Tribunali"
  And I fill in "Address" with "32"
  And I fill in "City" with "Napoli" 
  And I press "Save Changes"
  Then I should be on the Travel home page
  And I should see "Sorbillo was successfully created."