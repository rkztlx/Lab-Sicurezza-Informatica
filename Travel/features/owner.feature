Feature: OWNER features

Scenario: As a OWNER I want to HAVE OWNER SETTINGS so that I can UPDATE MY PLACE
    Given A registered owner as "owner@live.it","12345678"
    When The owner "owner@live.it" has a place
    And The owner go to the place+id page
    Then The owner should see "Modify"

Scenario: As a OWNER I want to HAVE OWNER SETTINGS so that I can DELETE MY PLACE
    Given A registered owner as "owner@live.it","12345678"
    When The owner "owner@live.it" has a place
    And The owner go to the place+id page
    Then The owner should see "Delete"

