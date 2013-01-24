Narou::Application.routes.draw do
  root :to => 'totext#index'
  post "totext/show" => "totext#show"
  get "totext/show"
  get "totext/index"
end

