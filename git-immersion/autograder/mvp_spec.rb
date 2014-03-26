require 'octokit'
require 'rspec'

describe "Github" do

  before (:all) do
    # TODO AgileVentures key. Do these expire??
    # Rate limit is 5000/hr
    # This ENV var comes from travis env:global:secure or set by admin
    # PAULS_GIT_IMMERSION_TOKEN is configured to allow only read of public access data
    @token = ENV['PAULS_GIT_IMMERSION_TOKEN']
    #START_DATE = '2014-01-01'
    @start_date = Date.today << 12 # months

    # This ENV var comes from GithubRspecGrader
    @user_repo = ENV['GITHUB_USERNAME']+'/gitimmersion'

    @client = Octokit::Client.new(:access_token => @token)
    @commits =  @client.commits_since(@user_repo, @start_date)
    @client.repository(@user_repo).parent.should be_nil
  end

  it "should find a repository on github for: #{@user_repo} [5 points]" do
    (@client.repository? @user_repo).should be_true
  end

  #TODO point per commit is possible?
  it "should have at least 3 commits since #{@start_date} [10 points]" do
    @commits.count.should be > 3
  end

  it "should have at least 6 commits since #{@start_date} [15 points]" do
    @commits.count.should be > 6
  end

  it "should have at least 9 commits since #{@start_date} [15 points]" do
    @commits.count.should be > 9
  end

end
