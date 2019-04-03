class AgenciesController < ApplicationController
  # before_action :set_user, only: :create
  # before_action :set_agency, only: [:show, :update, :destroy]

  # GET /agencies
  # def index
  #   @agencies = Agency.all
  #
  #   render json: @agencies
  # end

  # GET /agencies/1
  def show
    binding.pry
    render json: @agency
  end

  # POST /agencies
  # def create
  #   @agency = @user.build_agency(agency_params)

  #   if @agency.save
  #     render json: @agency, status: :created, location: user_agency_url(@user)
  #   else
  #     render json: @agency.errors, status: :unprocessable_entity
  #   end
  # end

  # # PATCH/PUT /agencies/1
  # def update
  #   if @agency.update(agency_params)
  #     render json: @agency
  #   else
  #     render json: @agency.errors, status: :unprocessable_entity
  #   end
  # end

  # # DELETE /agencies/1
  # def destroy
  #   @agency.destroy
  # end

  private

  # def set_user
  #   @user = User.find(params[:user_id])
  # end

  # def set_agency
  #   @agency = @current_user.agency
  # end

  def agency_params
    params.require(:agency).permit(:location, :business_name, :user_id)
  end
end
