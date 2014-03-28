[![Build Status](https://travis-ci.org/AgileVentures/AutoGraderExamples.png)](https://travis-ci.org/AgileVentures/AutoGraderExamples)

AutoGraderExamples
==================

Example Assignments for Use with the Ruby AutoGrader

**Usual platform:** linux or mac, ruby 1.9.3, git

#### **Install:**
- Fork on github, clone it, and cd there.
- `bundle install`
- `cucumber install`

#### **Git-immersion Note:** For deployment, and feature tests using Octokit.client calls to pass, you must do this!
- The OAuth ENV var `GIT_IMMERSION_TOKEN` used in mvp_spec.rb allows 5000/hr rate limit, whereas anonymous Octokit calls allow 60/hr.
- Generate the token on GitHub > Settings > Applications with **Zero Scopes**. Uncheck all boxes to allow only read access of public data.
- For production deployment and Your local, it is set by admin (you?), eg in /etc/environment and `source` it.
- For travis CI to work, it must be encrypted and added to .travis.yml under env:global:secure
- It is encrypted with `gem install travis && travis encrypt GIT_IMMERSION_TOKEN=<your personal token>`
- **Note** that pull requests from forks to AgileVentures/AutoGraderExamples will still fail due to security: http://docs.travis-ci.com/user/build-configuration/

#### **Run:**
- `cucumber` runs a feature per homework.
- `cucumber features/git_immersion_testing.feature` runs a single feature.

==================

**Directories:**
- git-immersion: homework added by instructor
  - autograder: tests run on student submissions, one per courseware section
  - public: skeletons and readmes included in courseware
  - solutions: instructor answers to homework problems, one with full score
- features: integration testing features, one per homework added by instructor
  - step_definitions: one per feature with similar name
- install: autograder installer infrastructure

**Naming conventions:**
 - top-level homework directory: 'boxcar-case'
 - integration features: 'snake_case' ending in 'testing'
