class GithubClient
  require 'singleton'
  include Singleton

  def connection
    @connection ||= Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end

  def fetch_issues user, repo, state='open'
    begin
      response = connection.get do |req|
        req.url "repos/#{user}/#{repo}/issues"
        req.params = {filter: 'all', state: state}
      end
      return JSON.parse(response.body)
    rescue Faraday::Error::ResourceNotFound, Faraday::Error::ClientError, Faraday::Error::ConnectionFailed => e
      puts (e.message)
    end
  end

  def fetch_combined_issues user, repo, count
    issues = fetch_issues user, repo
    if issues.size < count
      closed_issues = fetch_issues user, repo, 'closed'
      issues += closed_issues.first(count - issues.size)
    end
    return issues
  end
end