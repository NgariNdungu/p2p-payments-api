class UsersController < Devise::SessionsController
  include JSONAPI::Utils
  def create
    @user = User.new(resource_params)
    if @user.save
      jsonapi_render json: @user, status: :created
    else
      # binding.pry
      jsonapi_render_errors json: @user.errors, status: :bad_request
    end
  end
  def show
    @user=current_user
    jsonapi_render json: {data: {}}@user.account.id, status: :ok
  end
end
