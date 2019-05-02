require 'test_helper'
class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user=create(:user)
  end
  test 'Can signup users' do
    skip
    attributes = {
      full_name: 'some user',
      phone_number: '0701234567',
      email: 'user100@domain.com',
      password: 'astrongpassword'
    }
    # binding.pry
    post user_registration_url, params: { data: { 'type': 'users', 'attributes': {} } },
    headers: { 'Accept': 'application/vnd.api+json' }
    assert_response 201
    assert response.body['data'].present?
  end
  test "show account information" do
    skip
    # @user=create(:user)
    sign_in @user
    binding.pry
    get user_account_url(@user.id)
    assert_response 200
  end
  test "show user info" do
    skip
  end
  test "delete account" do
    skip
  end
  test "update user" do
    skip
  end
  test 
end
