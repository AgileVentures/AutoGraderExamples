require 'octokit'
require 'rspec'

describe "Github" do
  let(:repo_name ) { ENV['GITHUB_USERNAME']+'/gitimmersion' }
  let(:commits) { Octokit.commits_since(repo_name,'2014-01-01') }

  it "should find a gitimmersion repository for the user #{ ENV['GITHUB_USERNAME']+'/gitimmersion' } [5 points]" do
    (Octokit.repository? repo_name).should be_true
  end

  it 'should have at least 3 recent commits in name of user  [15 points]' do
      commits.count.should be > 3
      commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
  end

  it 'should have at least merge commit [5 points]' do
    multiple_parents = commits.collect{|c| c.parents.count > 1 || nil}
    merge_found = multiple_parents.compact.count > 0
    merge_found.should be true
  end
end
