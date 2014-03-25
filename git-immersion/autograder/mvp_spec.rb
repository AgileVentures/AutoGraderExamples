require 'octokit'
require 'rspec'

# This ENV var comes from GithubRspecGrader
USER_REPO = ENV['GITHUB_USERNAME']+'/gitimmersion'
# Changing this to 'Date.today << 6' could make previously valid scores lower if resubmitted later
START_DATE = '2014-01-01'

describe "Github" do

  let(:repo_name ) { USER_REPO }
  let(:commits) { Octokit.commits_since(repo_name, START_DATE) }

  it "should find a gitimmersion repository for the #{USER_REPO} [5 points]" do
    (Octokit.repository? repo_name).should be_true
    Octokit.repository(repo_name).parent.should be_nil
  end

   it "should have at least 3 commits since #{START_DATE} in #{USER_REPO}  [10 points]" do
      commits.count.should be > 3
      commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
   end

   it "should have at least 6 commits since #{START_DATE} in #{USER_REPO}   [15 points]" do
      commits.count.should be > 6
      commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
   end

   it "should have at least 9 commits since #{START_DATE} in #{USER_REPO}   [15 points]" do
      commits.count.should be > 9
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
