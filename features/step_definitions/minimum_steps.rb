Given(/^the file "(.*)" exists$/) do |file|
	@filename = file
  expect(File).to exist(file)
end

When(/^I read in the file$/) do
  @username = IO.read(@filename)
  expect(@username).not_to be_empty
end

Then(/^I should see that there is a github user with the name listed$/) do
  @result = `git ls-remote https://github.com/#{@username}/gitimmersion`
  expect(@result).not_to be_empty
end
