class Issue

  attr_accessor :title, :url, :pull_request, :state

  def initialize json
    @title = json['title']
    @url = json['url']
    @pull_request = json['pull_request'].values.compact.present?
    @state = json['state']
  end

  def self.fetch user, repo, count
    @@client ||= GithubClient.instance
    issues = @@client.fetch_combined_issues(user, repo, count).map do |json|
      self.new json
    end
    return issues
  end

end