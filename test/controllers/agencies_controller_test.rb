require 'test_helper'

class AgenciesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @agency = create(:agency)
  end

  test 'should create agency' do
    agency_params = {
      location: 'a nice location',
      business_name: 'right name',
      user_id: @user.id
    }
    assert_difference('Agency.count') do
      post agencies_url, params: { agency: agency_params }, as: :json
    end

    assert_response 201
  end

  test 'should show agency' do
    get agency_url(@agency), as: :json
    assert_response :success
  end

  test 'should update agency' do
    new_location = 'a better location'
    patch agency_url(@agency), params: { agency: { location: new_location } }, as: :json
    assert_response 200
    assert_equal new_location, @agency.reload.location
  end

  test 'should destroy agency' do
    assert_difference('Agency.count', -1) do
      delete agency_url(@agency), as: :json
    end

    assert_response 204
  end
end
