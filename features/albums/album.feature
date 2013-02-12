Feature: Manage Albums
  As a registered user of the website
  I want to manage my albums
  so I can keep them organized

  Scenario: I create an album
    Given I am logged in as "Steve" as a "subscriber"
    When I create an album
    Then I should see an created message

  Scenario: I can see my albums
    Given I am logged in as "Steve" as a "subscriber"
    And I create an album
    When I select the album
    Then I should see the album contents

  Scenario: Joe can not access Steve's albums
    Given I am logged in as "Steve" as a "subscriber"
    Given I create the album "Test Album"
     And I sign out
     And I am logged in as "Joe" as a "viewer"
    When I try the last URL
    Then I should see an error

  Scenario: Steve allows Joe to see an album
    Given I am logged in as "Joe" as a "viewer"
    And I sign out
    Given I am logged in as "Steve" as a "subscriber"
    Given I create the album "Family Album"
    And I share the album "Family Album" with "Joe"
    And I sign out
    And I sign in as "Joe"
    When I list albums
    Then I should see the album "Family Album"

