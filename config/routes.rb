Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'parses#new'
  get '/index', to: 'parses#index'
  post '/create', to: 'parses#create'
end
