Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'logins', registrations: 'users'}
  resources :agencies, only: [:create, :show, :update, :destroy]
  scope '/transactions/' do
  	resources :send_money, action: :send_money, controller: 'transaktions'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
