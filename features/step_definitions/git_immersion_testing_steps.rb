require 'open3'
require 'octokit'

def run_ag(subject, spec)
  git_user = File.read(subject).strip
  cli_string = "./new_grader -t GithubRspecGrader #{git_user} ../#{spec}"
  run_process cli_string
end

def run_process(cli_string, dir=@autograders)
  @test_output, @test_errors, @test_status = Open3.capture3(
      {'BUNDLE_GEMFILE' => 'Gemfile'}, cli_string, :chdir => dir
  )
  raise (cli_string + @test_output + @test_errors + @test_status.to_s) unless @test_status.success?
  puts "\n" + @test_errors if ( @test_errors != '' && @test_status.success? )
end

Given(/^I have the homework in "(.*?)"$/) do |hw|
  @hw_path = hw
  expect(Dir).to exist(@hw_path)
end

Given(/^AutoGraders are in "(.*)"$/) do |rag|
  expect(Dir).to exist(rag)
  @autograders = rag
end

When(/^I run AutoGrader for (.*) and (.*)$/) do |test_subject, spec|
  run_ag("#{@hw_path}/#{test_subject}", "#{@hw_path}/#{spec}")
end

Then(/^I should see the results include (.*)$/) do |expected_result|
  expect(@test_output).to match /#{expected_result}/
end

And(/^I should see the execution results with (.*)$/) do |test_title|
  success = @test_status.success? ? 'Success' : 'Failure'
  puts success + '!'
end


Given(/^I must rely on anonymous Octokit calls if running Travis CI on a pull request from a fork$/) do
  @travis_pull_request_from_fork =  (ENV['TRAVIS_SECURE_ENV_VARS'] == 'true') && (ENV['TRAVIS_PULL_REQUEST'] != 'false')
  if @travis_pull_request_from_fork
    puts "Travis operating on a pull request from a fork. Secure env variables are not permitted.\n" +
         "Using nil ENV['GIT_IMMERSION_TOKEN']: anonymous Octokit calls with a rate limit of 60/hr.\n"+
         "Beware of exceeding the Github API rate limit from repeating the tests / pull request builds from forks!"
  end
end

And(/^Or I have a valid token set in environment variable "([^"]*)"$/) do |var|
  #It's OK if this is nil because it will then create the anonymous client
  @token = ENV["#{var}"]
  if @token.nil? and not @travis_pull_request_from_fork
    puts "Go add an environment variable to your machine or secure env variable to travis.\n"+
         "See https://github.com/AgileVentures/AutoGraderExamples/blob/master/README.md"
  end
  @client = Octokit::Client.new(:access_token => @token)
  expect(@client).not_to be_nil
end

When(/^I check my remaining rate limit$/) do
  expect { @remaining_limit = @client.rate_limit.remaining }.not_to raise_error
end

Then(/^I should see it is a number, not nil$/) do
  puts "remaining rate limit per hour: #{@remaining_limit}"
  expect(@remaining_limit).not_to be_nil
  expect(@remaining_limit).to be_integer
end


Given(/^I have tests and token set up$/) do
  steps %Q{
    Given I must rely on anonymous Octokit calls if running Travis CI on a pull request from a fork
    And Or I have a valid token set in environment variable "GIT_IMMERSION_TOKEN"
    And I have the homework in "git-immersion"
    And AutoGraders are in "rag"
  }
end

When(/^I repeat the test of "(.*)" against autograder "(.*)"$/) do |subject, spec|
  # Do not set it to run very many times because it will be limited
  # to 60 hits per hour when Travis is running a pull request from a fork!
  @num_runs = 1
  @client = Octokit::Client.new(:access_token => @token)
  @start_limit = @client.rate_limit.remaining
  expect { @num_runs.times { run_ag("#{@hw_path}/solutions/#{subject}", "#{@hw_path}/autograder/#{spec}") } }.not_to raise_error
end

Then(/^I should see my remaining rate limit has declined$/) do
  #TODO why must the client be re-init here?
  #remaining = @client.rate_limit.remaining
  remaining = Octokit::Client.new(:access_token => @token).rate_limit.remaining
  decline = @start_limit - remaining
  puts "remaining rate limit: #{remaining}, declined by #{decline} in #{@num_runs} runs"
  expect(decline).to be > @num_runs
  expect(decline % @num_runs).to be 0
end
