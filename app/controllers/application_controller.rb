class ApplicationController < ActionController::API
  before_action :authenticate_user, :configure_permitted_parameters, if: :devise_controller?


  
end
