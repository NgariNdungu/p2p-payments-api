class ApplicationController < ActionController::API
  #before_action :authenticate_user!
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods


end

