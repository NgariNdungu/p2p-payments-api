class AgenciesController < ApplicationController
  include JSONAPI::Utils
  before_action :authenticate_user!
  before_action :set_agency, only: [:show, :update, :destroy]

  # GET /agencies
  # def index
  #   @agencies = Agency.all
  #   render json: @agencies
  # end

  # GET /agencies/1
  def show
    jsonapi_render json: @agency
  end

  # POST /agencies
  def create
    @agency = current_user.build_agency(resource_params)

    if @agency.save
      # TODO: set location header
      jsonapi_render json: @agency, status: :created
    else
      jsonapi_render json: @agency.errors, status: :bad_request
    end
  end

  # PATCH/PUT /agencies/1
  def update
    if @agency.update(resource_params)
      jsonapi_render json: @agency
    else
      jsonapi_render json: @agency.errors, status: :bad_request
    end
  end

  # DELETE /agencies/1
  def destroy
    # FIXME: destroy not working with jsonapi-utils
    @agency.destroy
  end

  private

  def set_agency
    @agency = current_user.agency
  end
end
