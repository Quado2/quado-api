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
      put '/users/add-role', to: 'users#add_role'
      put '/users/remove-role', to: 'users#remove_role'
      post 'users/verify-token', to: 'users#verify_token'

      post  'users/login', to 'session#login'
      
    end
  end
 
end
