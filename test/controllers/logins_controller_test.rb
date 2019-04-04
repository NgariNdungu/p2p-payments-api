require "test_helper"
class LoginsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = User.create(attributes_for(:user))
    @auth = ActionController::HttpAuthentication::Basic.encode_credentials(@user.email, @user.password)
    @unregistered_user = build(:user)
    @invalid_auth = ActionController::HttpAuthentication::Basic.encode_credentials(@unregistered_user.email, @unregistered_user.password)

  end
   
  test "can sigin registered user" do
    get login_url,
    headers: {"Accept": "application/vnd.api+json", "HTTP_AUTHORIZATION": @auth}
    assert_response 200
  end

  test "does not sign in unregistered user" do
    user = build(:user)
    get login_url,
    headers: {"Accept": "application/vnd.api+json", "HTTP_AUTHORIZATION": @invalid_auth }
    assert_response 401
  end

  test "should logout user" do
    skip
  end

end