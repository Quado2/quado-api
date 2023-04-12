Rails.application.routes.draw do
 
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }


  get '/current_user', to: 'current_user#index'

end
