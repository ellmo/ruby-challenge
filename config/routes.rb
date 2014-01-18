RubyChallenge::Application.routes.draw do
  get 'issues/index'
  root 'issues#index'
end
