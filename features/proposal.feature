Feature: Proposal

  In order to be informed about a proposal
  Logged in users need to see accurate data

  Scenario:
    Given a user is logged in as "user"
    And an open proposal that has expired titled "expired proposal"
    When I go to the page for the proposal titled "expired proposal"
    Then I should see /closed/ within ".state"