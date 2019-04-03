class LoginsController < Devise::SessionsController 

  def new
    email = request.headers['email']
    user = User.find_by(email: email) 
    if user && sign_in(user)
      @current_user = user
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