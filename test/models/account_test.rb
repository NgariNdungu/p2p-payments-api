require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'should create account for user' do
    assert_difference('Account.count') do
      create(:account, :for_user)
    end
  end

  test 'should create account for agency' do
    assert_difference('Account.count') do
      create(:account, :for_agency)
    end
  end

end
