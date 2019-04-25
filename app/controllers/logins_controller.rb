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
    current_user.update_column(:jti, "")
    binding.pry
    render status: 204
  end

end