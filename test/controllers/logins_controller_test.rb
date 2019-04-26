require "test_helper"
class LoginsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create(attributes_for(:user))
    @auth = ActionController::HttpAuthentication::Basic.encode_credentials(@user.email, @user.password)
    @unregistered_user = build(:user)
    @invalid_auth = ActionController::HttpAuthentication::Basic.encode_credentials(@unregistered_user.email, @unregistered_user.password)
  end
  
  test "Can sigin registered user" do
    get login_url, 
    headers: {"Accept": "application/vnd.api+json", "HTTP_AUTHORIZATION": @auth}
    assert_response 200
  end
  
  test "Does not sign in unregistered user" do
    get login_url, 
    headers: {"Accept": "application/vnd.api+json", "HTTP_AUTHORIZATION": @invalid_auth }
    assert_response 401
  end

  test "Can logout user" do
    get logout_url, 
    headers: {"Accept": "application/vnd.api+json", "HTTP_AUTHORIZATION": @auth}
    assert_response 204
  end

  test "Does not logout user with invalid token" do
    get logout_url,
    headers: {"Accept": "application/vnd.api+json", "HTTP_AUTHORIZATION": @invalid_auth }
    assert_response 401
  end

end