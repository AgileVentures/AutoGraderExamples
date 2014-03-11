Feature: Testing instructor created homeworks
  In order to check that the supplied homework can be graded by AutoGrader
  As a AutoGrader maintainer
  I would like these homeworks to be automatically tested on submit

  Scenario Outline: The project is set up and runs correctly
    Given I have the homework in "git-immersion"
    And gems are installed
    And AutoGraders are installed
    When I run AutoGrader for <test_subject> and <spec>
    Then I should see that the results are <expected_result>
    And I should see the execution results with <test_title>
  Examples:
    | test_title        | test_subject           | spec                   | expected_result       |
    | specs vs solution | solutions/username.txt | autograder/mvp_spec.rb | Score out of 100: 100 |

