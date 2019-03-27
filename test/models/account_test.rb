require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @user= create(:user, email: 'her@email.com', password: 'herpassword', phone_number: '0712345678', full_name:'her full_name')
  end

  test 'Should allow users to own more than one account' do
      assert_difference('Account.count') do
      create(:account, owner: @user)
    end
  end

  test 'Should delete account ' do
    account = create(:account, owner: @user)
    assert_difference('Account.count', -1) do
      account.destroy
    end
  end
end
