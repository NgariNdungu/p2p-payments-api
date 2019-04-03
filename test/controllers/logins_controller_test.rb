require "test_helper"
class LoginsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   
  test "Can sigin users" do
    user = User.create(attributes_for(:user))
    get login_url,
    headers: {"Accept": "application/vnd.api+json", "email": user.email, "password": user.password }
    assert_response 200
  end

  test "does not sign in unregistered user" do
    user = build(:user)
    get login_url,
    headers: {"Accept": "application/vnd.api+json", "email": user.email, "password": user.password }
    assert_response 401
  end

end