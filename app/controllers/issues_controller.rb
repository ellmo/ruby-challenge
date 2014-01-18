class IssuesController < ApplicationController
  def index
    @issues = Issue.fetch 'sinatra', 'sinatra', 50
  end
end
