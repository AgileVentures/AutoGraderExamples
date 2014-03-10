Given(/^the file "(.*)" exists$/) do |file|
  expect(File).to exist(file)
end

When(/^I read in the file$/) do
  pending # express the regexp above with the code you wish you had
end

Then(/^I should see that there is a github user with the name listed$/) do
  pending # express the regexp above with the code you wish you had
end
