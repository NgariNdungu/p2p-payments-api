class LoginsController < Devise::SessionsController 

  def new
    authenticate_or_request_with_http_basic do |email,password|
      user = User.find_by(email: email) 
      if user && user.valid_password?(password )
        sign_in(:user, user)
        render json: {data: {auth_token: request.env['warden-jwt_auth.token'] }}
      else
        render json: {data: {title: 'unauthorized', details: 'Incorrect username, password or missing token'}}, status: 401
      end
    end
  end


#   /logout
  # def destroy
  #   revoke_jwt(current_user)
  # end
end