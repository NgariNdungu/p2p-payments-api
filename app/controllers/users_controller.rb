class UsersController < Devise::SessionsController
  include JSONAPI::Utils
  before_action :authenticate_user!, only:[:show, :update, :destroy]
  def create
    @user = User.new(resource_params)
    if @user.save
      jsonapi_render json: @user, status: :created
    else
      jsonapi_render_errors json: @user.errors, status: :bad_request
    end
  end
  def show
    @user=current_user
    jsonapi_render json: @user, status: :ok
  end

  def destroy
    # TODO. Either remove all associated accounts and transactions for users to prevent mix-up for new registration with same details
    current_user.destroy
    jsonapi_render json: @user, status: :no_content
  end

  def update
    if current_user.update(resource_params)
      jsonapi_render json: @current_user, status: :ok
    else
      jsonapi_render json: @current_user.errors, status: :bad_request
    end
  end
end
