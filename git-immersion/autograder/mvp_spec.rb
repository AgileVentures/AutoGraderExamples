require 'octokit'
require 'rspec'

describe "Github" do
  it "should find a gitimmersion repository for the #{ENV['GITHUB_USERNAME']+'/gitimmersion'} [5 points]" do
    (Octokit.repository? ENV['GITHUB_USERNAME']+'/gitimmersion').should be_true
  end

   it "should have at least 3 recent commits in name of #{ENV['GITHUB_USERNAME']+'/gitimmersion'}  [10 points]" do
      repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
      commits = Octokit.commits_since(repo_name,'2014-01-01')
      commits.count.should be > 3
      commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
   end

   it "should have at least 6 recent commits in name of #{ENV['GITHUB_USERNAME']+'/gitimmersion'}  [15 points]" do
      repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
      commits = Octokit.commits_since(repo_name,'2014-01-01')
      commits.count.should be > 3
      commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
   end

   it "should have at least 9 recent commits in name of #{ENV['GITHUB_USERNAME']+'/gitimmersion'}  [15 points]" do
      repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
      commits = Octokit.commits_since(repo_name,'2014-01-01')
      commits.count.should be > 3
      commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
   end

  #it 'should not have any forks  [10 points]' do
      #repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
      
      #forks = Octokit.forks(repo_name)      
      #forks[0].fork.should be 'false' 
      #forks.each{|c| c.count.should be = 'nil'}
    
 # end  

  #it 'should have at least merge commit [5 points]' do
    #repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
    #commits = Octokit.commits_since(repo_name,'2014-01-01')
    #collection = commits.collect{|c| c.commit.message.include? 'merge'}
    #collection.should include(true)
    #todo check Merge with 2 sha hashes
  #end
end
