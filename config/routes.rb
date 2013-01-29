Narou::Application.routes.draw do
  root :to => 'totext#index'
  post "totext/show" => "totext#show"
  get "totext/show"
  get "totext/index"
  get "totext/item"
match 'totext/item/*item', :to => 'totext#item'
end

