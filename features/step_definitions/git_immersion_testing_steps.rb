require 'open3'

def run_ag(subject, spec)
  git_user = File.read(subject).strip
  cli_string = "./new_grader -t GithubRspecGrader #{git_user} ../#{spec}"
  #cli_string = cli_string.gsub("\n", ' ')
  run_process cli_string
end

def run_process(cli_string, dir=@autograders)
  @test_output, @test_errors, @test_status = Open3.capture3(
      { 'BUNDLE_GEMFILE' => 'Gemfile' }, cli_string, :chdir => dir
  )
  raise ( @test_output + @test_errors + @test_status.to_s ) unless @test_status.success?
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
