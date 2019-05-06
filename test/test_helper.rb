ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include FactoryBot::Syntax::Methods

  # Add more helper methods to be used by all tests here...
end
class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def jsonapi_request(resource: nil, resource_type:, params:)
    {
      "data": {
        "type": resource_type,
        "attributes": params
      }.merge(resource ? { "id": resource.id } : {})
    }
  end
end
