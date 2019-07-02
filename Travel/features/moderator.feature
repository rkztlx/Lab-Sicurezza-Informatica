Feature: MODERATOR features

Scenario: As a MODERATOR I want to HAVE MODERATOR SETTINGS so that I can REMOVE a REVIEW
    Given A registered moderator as "moderator@live.it", "12345678"
    And Exists a place
    And Exists a review on the place
    And The moderator go to the place+id page
    Then The moderator should see "Delete review"

Scenario: As a MODERATOR I want to HAVE MODERATOR SETTINGS so that I can REMOVE a PLACE
    Given A registered moderator as "moderator@live.it", "12345678"
    And Exists a place
    And The moderator go to the place+id page
    Then The moderator should see "Delete"
