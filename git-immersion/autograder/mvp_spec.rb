require 'octokit'
require 'debugger'
require 'rspec'

def check_client
  if CLIENT.access_token.nil?
    warn "WARNING: ENV['GIT_IMMERSION_TOKEN'] is nil, using anonymous GitHub API.\n"+
      "Remaining rate limit: #{@client.rate_limit.remaining}. Time to reset: #{@client.rate_limit.resets_in / 60} minutes"
  end
  begin
    CLIENT.rate_limit.remaining
  rescue Octokit::Unauthorized => e
    raise e, "ERROR: Invalid token likely provided in ENV['GIT_IMMERSION_TOKEN']: #{e.message}", e.backtrace
  end
end

describe "Github" do

  # START_DATE = '2014-01-01'
  START_DATE = Date.today << 12 # months

  # This ENV var comes from GithubRspecGrader
  GITHUB_USERNAME = ENV['GITHUB_USERNAME'] || 'tansaku'
  USER_REPO = GITHUB_USERNAME + '/gitimmersion'
  CLIENT = Octokit::Client.new(:access_token => ENV['GIT_IMMERSION_TOKEN'])
  check_client
  COMMITS = CLIENT.commits_since(USER_REPO, START_DATE)


  before (:all) do
    # Rate limit is 5000/hr with good token, 60/hr with
    # This ENV var comes from travis env:global:secure or set by admin
    # TODO Do these tokens expire??
    # GIT_IMMERSION_TOKEN is configured to allow only read of public access data
    
  end


  it "should find a repository on github for: #{USER_REPO} [20 points]" do
    (CLIENT.repository? USER_REPO).should be_true
  end

  it "should be a freshly created repo, not a fork  [50 points]" do
    CLIENT.repository(USER_REPO).parent.should be_nil
  end

  #TODO point per commit is possible?
  it "should have at least 3 commits since #{START_DATE} [5 points]" do # can do #{COMMITS.count} have to use constants
    COMMITS.count.should be > 0
  end

  it "should have at least 6 commits since #{START_DATE} [10 points]" do
    COMMITS.count.should be > 6
  end

  it "should have at least 9 commits since #{START_DATE} [10 points]" do
    COMMITS.count.should be > 9
  end

  it "should have some tags [5 points]" do
    CLIENT.tags(USER_REPO).should_not be_empty
  end

end
