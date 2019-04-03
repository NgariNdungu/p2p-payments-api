Rails.application.routes.draw do
  devise_for :users, controllers: {sessions: 'logins', registrations: 'users'}

  devise_scope :user do
    get 'sign_in', to: 'logins#create'
    get 'sign_out',  to: 'logins#destroy'
    post 'sign_up', to: 'users#create'
  
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

