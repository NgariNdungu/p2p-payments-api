class LoginsController < Devise::SessionsController 
  before_action :authenticate_user!

  def login
    if user_signed_in?
      render json: { data: { id: current_user.jti, type: 'Token', attributes: {auth_token: request.env['warden-jwt_auth.token'],token_type: 'Bearer'}} }
    else
      render json: { errors: [{ title: 'unauthorized', details: 'Invalid Credentials'}]}, status: 401
    end
  end


  # /logout
  def logout   
    if current_user && current_user.logout(current_user.jwt_payload, current_user)
      render status: 204
    else
      render json: { errors: [{ title: 'unauthorized', details: 'Invalid Credentials'}]}, status: 401
    end
  end

end