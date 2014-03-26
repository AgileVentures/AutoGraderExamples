Feature: Testing instructor created homeworks
  In order to check that the supplied homework can be graded by AutoGrader
  As a AutoGrader maintainer
  I would like these homeworks to be automatically tested on submit

  Scenario Outline: The project is set up and runs correctly
    Given I have the homework in "git-immersion"
    And AutoGraders are in "rag"
    When I run AutoGrader for <test_subject> and <spec>
    Then I should see the results include <overall_score>
    And I should see the results include <github_username>
    And I should see the execution results with <test_title>
  Examples:
    | test_title              | test_subject            | spec                   | overall_score        | github_username |
    | forked repo             | solutions/jhasson84.txt | autograder/mvp_spec.rb | Score out of 100: 0  | jhasson84       |
    | non-forked repo         | solutions/tansaku.txt   | autograder/mvp_spec.rb | Score out of 100: 12 | tansaku         |
    | non-forked, > 6 commits | solutions/apelade.txt   | autograder/mvp_spec.rb | Score out of 100: 67 | apelade         |

    # TODO ideally we should be stubbing the octokit gem ... use https://github.com/vcr/vcr ?
    # TODO Local or git repos that will never disappear ?
