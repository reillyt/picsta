Feature: Email notice
  In order to keep up with changes to my shares
  As a user
  I want to be able to be notified when a share changes

  Scenario: Sign up to be notified
    Given An album is shared with "Joe"
    Given I sign in as "Joe"
      And I list albums
    When I click subscribe
    Then I see a successful subscribe message

  Scenario: Subscriber gets an email
    Given An album is shared with "Joe"
    Given I sign in as "Joe"
      And I list albums
      And I click subscribe
     When An image is added to a shared album
      And Album email notifications are processed
    Then "joe@example.com" should receive 1 emails
