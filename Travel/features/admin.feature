Feature: ADMIN features

Scenario: As an ADMIN I want to HAVE ADMIN SETTINGS so that I can DELETE USERS
    Given A registered admin as "admin@live.it", "12345678"
    And another user exists
    And The admin go to the user profile
    Then The admin should see "Delete"

Scenario: As an ADMIN I want to HAVE ADMIN SETTINGS so that I can BAN USERS
    Given A registered admin as "admin@live.it", "12345678"
    And another user exists
    And The admin go to the user profile
    And The admin click to the "Ban" link
    Then the user is banned

Scenario: As an ADMIN I want to HAVE ADMIN SETTINGS so that I can UNBAN USERS
    Given A registered admin as "admin@live.it", "12345678"
    And another banned user exists
    And The admin go to the user profile
    And The admin click to the "Unban" link
    Then the user is not banned

Scenario: As an ADMIN I want to HAVE ADMIN SETTINGS so that I can PROMOTE USERS
    Given A registered admin as "admin@live.it", "12345678"
    And another user exists
    And The admin go to the user profile
    Then The admin should see "Promote as"

Scenario: As an ADMIN I want to HAVE ADMIN SETTINGS so that I can DEMOTE USERS
    Given A registered admin as "admin@live.it", "12345678"
    And another moderator not banned and not admin exists
    And The admin go to the user profile
    Then The admin should see "Demote as"