require 'octokit'
require 'rspec'

describe "Github" do
  it "should find a gitimmersion repository for the user [5 points]" do
    (Octokit.repository? ENV['GITHUB_USERNAME']+'/gitimmersion').should be_true
  end
end
