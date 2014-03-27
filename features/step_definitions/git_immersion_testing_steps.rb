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


Given(/^I have a valid token set in environment variable "([^"]*)"$/) do |var|
  @token = ENV["#{var}"]
  expect(@token).not_to be_nil
end

When(/^I check my remaining rate limit$/) do
  @client = Octokit::Client.new(:access_token => @token)
  expect(@client).not_to be_nil
  expect { @remaining_limit = @client.rate_limit.remaining }.not_to raise_error
end

Then(/^I should see it is a number, not nil$/) do
  puts "remaining rate limit per hour: #{@remaining_limit}"
  expect(@remaining_limit).not_to be_nil
  expect(@remaining_limit).to be_integer
end


Given(/^I have tests and token set up$/) do
  steps %Q{
    Given I have a valid token set in environment variable "GIT_IMMERSION_TOKEN"
    And I have the homework in "git-immersion"
    And AutoGraders are in "rag"
  }
end

When(/^I repeat the test of "(.*)" against autograder "(.*)" for (\d+) times$/) do |subject, spec, reps|
  @num_runs = reps.to_i
  @client = Octokit::Client.new(:access_token => @token)
  @start_limit = @client.rate_limit.remaining
  expect { @num_runs.times { run_ag("#{@hw_path}/solutions/#{subject}", "#{@hw_path}/autograder/#{spec}") } }.not_to raise_error
end

Then(/^I should see my remaining rate limit has declined a few times more than that$/) do
  remaining = Octokit::Client.new(:access_token => @token).rate_limit.remaining
  decline = @start_limit - remaining
  puts "remaining rate limit #{remaining} declined by #{decline} in #{@num_runs} runs"
  expect(decline).to be > @num_runs
  expect(decline % @num_runs).to be 0
end

