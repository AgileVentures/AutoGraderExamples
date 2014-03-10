Feature: Minimum Viable Product
  As an instructor
  So that I can assess my students git abilities
  I would like to check that they have created a gitimmersion repo on github

  Scenario: Load the file with git user name
    Given the file "username.txt" exists
    When I read in the file
    Then I should see that there is a github user with the name listed

