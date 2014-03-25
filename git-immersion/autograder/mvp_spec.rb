require 'octokit'
require 'rspec'

# This is Paul's personal github api key, switch to AV or saasbook one. Do they expire??
# Rate limit with OAuth is 5000/hr
ACCESS_TOKEN = 'b565dd7c2925d68674dc6998d6cdc0e16325b094'

# Is it reasonable to assume one year before today would always be less than any HW due date limits?
# If they submit beyond that, will it affect their score, grade or certificate record??
START_DATE = Date.today << 12 #(months)
#START_DATE = '2014-01-01'

# This ENV var comes from GithubRspecGrader
USER_REPO = ENV['GITHUB_USERNAME']+'/gitimmersion'

# TODO: Sam suggests a point per commit

describe "Github" do

  before (:all) do
    @client = Octokit::Client.new(:access_token => ACCESS_TOKEN)
    @commits =  @client.commits_since(USER_REPO, START_DATE)
    @client.repository(USER_REPO).parent.should be_nil
  end

  it "should find a repository on github for: #{USER_REPO} [10 points]" do
    (@client.repository? USER_REPO).should be_true
  end

  it "should have at least 3 commits since #{START_DATE} [20 points]" do
    @commits.count.should be > 3
    # Can't assert these because Students may have commits locally under different
    # name than github username, eg 'saasbook' add test repo for that case
    #@commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
  end

  it "should have at least 6 commits since #{START_DATE} [35 points]" do
    @commits.count.should be > 6
    #@commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
  end

  it "should have at least 9 commits since #{START_DATE} [35 points]" do
    @commits.count.should be > 9
    #@commits.each {|c| c.author.login.should eq ENV['GITHUB_USERNAME']}
  end

end

#instead of author login, is there a better chance they use the same email address?
#@commits[x].commit.author.email
#@commits[x].commit.committer.email

#it 'should not have any forks  [10 points]' do
#repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
#forks = Octokit.forks(repo_name)
#forks[0].fork.should be 'false'
#forks.each{|c| c.count.should be = 'nil'}
# end

#it 'should have at least one merge commit [5 points]' do
#repo_name = ENV['GITHUB_USERNAME']+'/gitimmersion'
#COMMITS = Octokit.COMMITS_since(repo_name,'2014-01-01')
#collection = COMMITS.collect{|c| c.commit.message.include? 'merge'}
#collection.should include(true)
#todo check Merge with 2 sha hashes
#end
#end