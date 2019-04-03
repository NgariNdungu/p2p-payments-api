Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'logins', registrations: 'users' }
  
  devise_scope :user do
    get '/login', to: 'logins#new'
    get '/logout',  to: 'logins#destroy'
    post '/users',  to: 'users#create'
    get 'logout', to: 'logins#destroy'
  end
  resources :users do
    resource :agency, only: [:create, :show, :update, :destroy]
  end
  scope '/transactions/' do
    post 'withdrawal', to: 'transaktions#withdraw'
    post 'deposit', to: 'transaktions#deposit'
    post 'send_money', to: 'transaktions#send_money'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
