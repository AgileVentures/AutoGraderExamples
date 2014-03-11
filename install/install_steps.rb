require 'open3'

def run_in_dir(arg_string, dir=@dir)
  @test_output, @test_errors, @test_status = Open3.capture3(arg_string, :chdir => dir)
  puts @test_errors if @test_errors != ''
end


## Given Steps

Given /^that I am in the project root directory "(.*?)"$/ do |project_dir|
  @project_dir = project_dir
  expect(File.basename(Dir.getwd)).to eq @project_dir
end

Given(/^I go to the AutoGrader directory "(.*?)"$/) do |rag|
  @dir = rag
end

Given(/^it has an origin of "(.*?)"$/) do |origin|
  run_in_dir("git remote -v")
  origin = "https://github.com/#{origin}".gsub('.git', '')
  @test_output = @test_output.gsub('.git', '')
  expect(@test_output).to match(/origin\t#{origin} \(fetch\)/)
end


## When Steps

When(/^I install gems$/) do
  @dir = Dir.getwd
  @test_output, @test_errors, @test_status = Open3.capture3(
      { 'BUNDLE_GEMFILE' => 'Gemfile' }, 'bundle install'
  )
end

When(/^I install or check "(.*)" as "(.*)"$/) do |repo, dir|
  if ! Dir.exists?(dir)
    puts "Clone AutoGraders as '#{dir}'"
    @test_output, @test_errors, @test_status = Open3.capture3("git clone https://github.com/#{repo} #{dir}" )
  else
    puts "Existing '#{dir}'. Skip clone, fetch instead."
    run_in_dir("git fetch origin", dir )
  end
  @dir = dir if  Dir.exists?(dir)
  steps %Q{Given it has an origin of "#{repo}"}
end

When(/^I fetch the latest on origin branch "(.*?)"$/) do |branch|
  @branch = branch
  run_in_dir("git fetch origin #{@branch}")
end

When(/^I change to branch "(.*?)"$/) do |branch|
  run_in_dir("git checkout #{branch}")
end

And(/^I install the AutoGrader gems$/) do
  @test_output, @test_errors, @test_status = Open3.capture3(
      { 'BUNDLE_GEMFILE' => 'Gemfile' }, 'bundle install', :chdir => @dir
  )
end

## Then Steps

Then(/^I should see no difference$/) do
  run_in_dir("git diff origin/#{@branch}")
  expect(@test_output == '').to be_true
  #puts "'#{@dir}' matches origin/#{@branch} branch"
end


And(/^I should see (\d+) gems$/) do |num|
  @test_output, @test_errors, @test_status = Open3.capture3(
      { 'BUNDLE_GEMFILE' => 'Gemfile' }, 'bundle list', :chdir => @dir
  )
  expect(@test_output.lines.select{|x| x.match /\*/}).to have(num).gems
end

# duplicate steps from hw_testing_steps

Then(/^I should see that there are no errors$/) do
  expect(@test_status).to be_success
end

Then(/I should see the execution results$/) do
  puts @test_status
  puts @test_errors
  puts @test_output
end
