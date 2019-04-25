Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'logins', registrations: 'users' }
  
  devise_scope :user do
    get '/login', to: 'logins#login'
    get '/logout',  to: 'logins#logout'
    post '/users',  to: 'users#create'
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
  # get 'statement', to: 'statement#generate_pdf'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
