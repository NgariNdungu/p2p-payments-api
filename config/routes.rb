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
    post 'withdrawal', to: 'transactions#withdraw'
    post 'deposit', to: 'transactions#deposit'
    post 'send_money', to: 'transactions#send_money'
  end

  get '/accounts/:account_id/statement', to: 'statement#get_statement', as: 'statement'
  # get '/statement', to: 'statement#get_statement'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
