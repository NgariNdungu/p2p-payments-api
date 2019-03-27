require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  setup do
    @user= create(:user, email: 'her@email.com', password: 'herpassword', phone_number: '0712345678', full_name:'her full_name')
  end
  test 'should create account for user' do
    assert_difference('Account.count') do
      create(:account, owner: @user)
    end
  end
  
  test 'should create account for agency on creation' do
    assert_difference('Account.count') do
      create(:agency, business_name: 'poorly chosen', location: 'kwa giza', user: @user)
    end
  end

  test 'Should only allow one account for agency' do
    assert_no_difference('Account.count') do
      create(:account, :for_agency)
    end
  end

  test 'Should allow users to own more than one account' do
    assert_difference('Account.count') do
      create(:account, :for_user)
    end
  end
end
