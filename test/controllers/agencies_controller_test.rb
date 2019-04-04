require 'test_helper'

class AgenciesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @user = create(:user)
    get login_url,
    headers: {"Accept": "application/vnd.api+json", "email": @user.email, "password": @user.password }
    @results = JSON.parse(response.body)
    @token = @results["data"]["auth_token"]

  end

  # test 'should create agency' do
  #   user = create(:user)
  #   agency_params = {
  #     location: 'a nice location',
  #     business_name: 'right name',
  #   }
  #   assert_difference('Agency.count') do
  #     post user_agency_url(user), params: { agency: agency_params }, as: :json
  #   end

  #   assert_response 201, 'should create an agency given valid parameters'
  # end

  test 'should show agency' do
    get user_agency_url(@user), headers: {"Accept": "application/vnd.api+json", "Authorization": "Bearer #{@token}" }
    assert_response :success
  end

  # test 'should update agency' do
  #   new_location = 'a better location'
  #   patch user_agency_url(@user), params: { agency: { location: new_location } }, as: :json
  #   assert_response 200
  #   assert_equal new_location, @agency.reload.location,
  #                'should update the agency location'
  # end

  # test 'should destroy agency' do
  #   assert_difference('Agency.count', -1) do
  #     delete user_agency_url(@user), as: :json
  #   end

  #   assert_response 204
  # end
end
