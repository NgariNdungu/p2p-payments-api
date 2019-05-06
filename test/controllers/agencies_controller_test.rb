require 'test_helper'

class AgenciesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  require 'devise/jwt/test_helpers'
  setup do
    @user = create(:agency).user
    @auth = ActionController::HttpAuthentication::Basic.encode_credentials(@user.email, @user.password)
    get login_url,
    headers: { "Accept": "application/vnd.api+json", "Authorization": @auth }
    @results = JSON.parse(response.body)
    @token = @results['data']['attributes']['auth_token']
  end

  test 'should create agency' do
    user = create(:user)
    agency_params = {
      location: 'a nice location',
      business_name: 'right name'
    }
    assert_difference('Agency.count') do
      post user_agency_url(user), params: jsonapi_request(params: agency_params, resource_type: 'agencies'),
      headers: Devise::JWT::TestHelpers.auth_headers({}, user)
    end

    assert_response 201, 'should create an agency given valid parameters'
  end

  test 'should show agency' do
    get user_agency_url(@user), headers: { 'Accept': 'application/vnd.api+json', 'Authorization': @auth }
    assert_response :success
  end

  test 'should update agency' do
    new_location = 'a better location'
    patch user_agency_url(@user),
          params: jsonapi_request(resource: @user.agency, params: { location: new_location },
                                  resource_type: 'agencies'),
          headers: Devise::JWT::TestHelpers.auth_headers({}, @user)
    assert_response 200
    assert_equal new_location, @user.agency.reload.location,
                 'should update the agency location'
  end

  test 'should destroy agency' do
    skip
    assert_difference('Agency.count', -1) do
      delete user_agency_url(@user),
             headers: Devise::JWT::TestHelpers.auth_headers({}, @user)
    end

    assert_response 204
  end
end
