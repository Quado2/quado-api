Rails.application.routes.draw do
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post '/roles', to: 'roles#create'
    end
  end
 
end
