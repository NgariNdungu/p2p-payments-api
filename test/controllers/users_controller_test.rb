require "test_helper"
class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
   
  test "Can signup users" do
    post users_url, params: {data: {'type': 'user','attributes':attributes_for(:user)}},
    headers: {'Accept': 'application/vnd.api+json'}
    assert_response 201
  end
end