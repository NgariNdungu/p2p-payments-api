class ApplicationController < ActionController::API
  before_action :authenticate_user!, :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:data, :type, attributes: [:full_name, :phone_number, :email, :password]])
  end

  
end
