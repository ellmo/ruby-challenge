class Issue

  def initialize json
    @title = json['title']
    @url = json['url']
    @pull_request = json['pull_request'].values.compact.present?
  end

  def self.fetch user, repo, count
    @@client ||= GithubClient.instance
    issues = @@client.fetch_combined_issues(user, repo, count).map do |json|
      self.new json
    end
    return issues
  end

end