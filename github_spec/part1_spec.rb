require 'octokit'

describe "Github" do
  it "should find a ruby-sample repository for the user [5 points]" do

    (Octokit.repository? ENV['GITHUB_USERNAME']+'/ruby-sample').should be_true
  end
  it "should have been forked from https://github.com/heroku/ruby-sample [5 points]" do

    repo = Octokit.repository? ENV['GITHUB_USERNAME']+'/ruby-sample'
    repo.parent.full_name.should eq "heroku/ruby-sample"
  end
end
