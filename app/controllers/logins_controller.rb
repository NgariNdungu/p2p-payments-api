class LoginsController < Devise::SessionsController 
  

  #signs in a  user and returns a token

  def new
    email = request.headers['email']
    user = User.find_by(email: email) 
    if user && user.valid_password?(request.headers['password'])
      sign_in(:user, user)
      render json: {data: {auth_token: request.env['warden-jwt_auth.token'] }}
    else
      render json: {data: {title: 'unauthorized', details: 'Incorrect username, password or missing token'}}, status: 401
    end
  end


#   /logout
  def destroy
        # revok
  end
end