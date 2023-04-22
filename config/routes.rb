Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do

      # ROLES
      post '/roles', to: 'roles#create'
      get '/roles', to: 'roles#getall'
      get '/roles/:id', to: 'roles#find'

      # USERS
      post '/users', to: 'users#create'
      put '/users', to: 'users#update'
      get '/users', to: 'users#getall'
      get '/users/:id', to: 'users#find'
      
    end
  end
 
end
