class UsersController < Devise::SessionsController 
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end




  def user_params
    params.require(:data).permit(attributes:[:full_name, :phone_number, :password, :email])
  end
end