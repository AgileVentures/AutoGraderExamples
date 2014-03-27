require 'octokit'
require 'rspec'


describe "Github" do

  # START_DATE = '2014-01-01'
  START_DATE = Date.today << 12 # months

  # This ENV var comes from GithubRspecGrader
  USER_REPO = ENV['GITHUB_USERNAME']+'/gitimmersion'

  before (:all) do
    # Rate limit is 5000/hr
    # This ENV var comes from travis env:global:secure or set by admin
    # TODO Do these expire??
    # GIT_IMMERSION_TOKEN is configured to allow only read of public access data
    @token = ENV['GIT_IMMERSION_TOKEN']
    @client = Octokit::Client.new(:access_token => @token)
    @commits =  @client.commits_since(USER_REPO, START_DATE)
  end


  it "should find a repository on github for: #{USER_REPO} [20 points]" do
    (@client.repository? USER_REPO).should be_true
  end

  it "should be a freshly created repo, not a fork  [50 points]" do
    @client.repository(USER_REPO).parent.should be_nil
  end

  #TODO point per commit is possible?
  it "should have at least 3 commits since #{START_DATE} [5 points]" do
    @commits.count.should be > 3
  end

  it "should have at least 6 commits since #{START_DATE} [10 points]" do
    @commits.count.should be > 6
  end

  it "should have at least 9 commits since #{START_DATE} [10 points]" do
    @commits.count.should be > 9
  end

  it "should have more some tags [5 points]" do
    @client.tags(USER_REPO).should_not be_nil
  end

end
