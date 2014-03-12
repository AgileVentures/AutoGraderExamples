[![Build Status](https://travis-ci.org/AgileVentures/AutoGraderExamples.png)](https://travis-ci.org/AgileVentures/AutoGraderExamples)

AutoGraderExamples
==================

Example Assignments for Use with the Ruby AutoGrader

**Usual platform:** linux or mac, ruby 1.9.3, git

**Install:**
- Fork on github, clone it, and cd there.
- `bundle install`
- `cucumber install`

**Run:**
- `cucumber` runs a feature per homework.
- `cucumber features/git_immersion_testing.feature` runs a single feature.

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
