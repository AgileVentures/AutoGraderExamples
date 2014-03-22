require 'octokit'
require 'rspec'

describe "Github" do
  it "should find a gitimmersion repository for the user [5 points]" do
    (Octokit.repository? ENV['GITHUB_USERNAME']+'/gitimmersion').should be_true
  end

  it 'should have at least 3 recent commits in name of user  [15 points]' do
      repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
      commits = Octokit.commits_since(repo_name,'2014-01-01')
      commits.count.should be > 3
      commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
  end

  it 'should have at least merge commit [5 points]' do
    repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
    commits = Octokit.commits_since(repo_name,'2014-01-01')
    multiple_parents = commits.collect{|c| c.parents.count > 1 || nil}
    merge_found = multiple_parents.compact.count > 0
    merge_found.should be true
  end
end
