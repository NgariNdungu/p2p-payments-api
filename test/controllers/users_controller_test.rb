require 'test_helper'
class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'Can signup users' do
    attributes = {
      full_name: 'some user',
      phone_number: '0701234567',
      email: 'user100@domain.com',
      password: 'astrongpassword'
    }
    post user_registration_url, params: { data: { 'type': 'users', 'attributes': attributes } },
    headers: { 'Accept': 'application/vnd.api+json' }
    assert_response 201
    assert response.body['data'].present?
  end
end
