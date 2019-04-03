class ApplicationController < ActionController::API
  before_action :authenticate_user!, if: :devise_controller?

end

