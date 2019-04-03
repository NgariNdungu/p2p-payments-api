Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'logins', registrations: 'users'}
  
  devise_scope :user do
    get '/login', to: 'logins#new'
    get '/logout',  to: 'logins#destroy'
    post '/users',  to: 'users#create'
  end
  resources :agencies, only: [:create, :show, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
