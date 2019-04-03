require 'test_helper'

class AgenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @agency = create(:agency)
    @user = @agency.user
  end

  test 'should create agency' do
    user = create(:user)
    agency_params = {
      location: 'a nice location',
      business_name: 'right name',
    }
    assert_difference('Agency.count') do
      post user_agency_url(user), params: { agency: agency_params }, as: :json
    end

    assert_response 201, 'should create an agency given valid parameters'
  end

  test 'should show agency' do
    get user_agency_url(@user), as: :json
    assert_response :success
  end

  test 'should update agency' do
    new_location = 'a better location'
    patch user_agency_url(@user), params: { agency: { location: new_location } }, as: :json
    assert_response 200
    assert_equal new_location, @agency.reload.location,
                 'should update the agency location'
  end

  test 'should destroy agency' do
    assert_difference('Agency.count', -1) do
      delete user_agency_url(@user), as: :json
    end

    assert_response 204
  end
end
