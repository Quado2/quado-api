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
      delete '/users/:id', to: 'users#delete_user'
      put '/users/add-role', to: 'users#add_role'
      put '/users/remove-role', to: 'users#remove_role'
      get '/users/verify-token', to: 'users#verify_token'

      post  'users/login', to: 'session#login'
      post 'users/logout', to: 'session#logout'
      get 'users/refresh-token', to: 'session#refresh_access_token'

      # get '/users/:id', to: 'users#find'

      resources :privileges
      resources :mods
      
    end
  end
 
end
