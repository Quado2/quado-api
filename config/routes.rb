Rails.application.routes.draw do
  namespace :api, defaults: {format: :jsonn} do
    namespace :v1 do
      post '/roles', to: 'roles#create'
    end
  end
  get
end
