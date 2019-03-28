require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
	# end	
  test 'user is valid' do
  	@user=build(:user)
  	assert @user.valid?
  end
  test 'phone number is of correct format' do
  	@user_with_invalid_phone=build_stubbed(:user_with_invalid_phone)
  	refute @user_with_invalid_phone.valid?
  	refute_empty @user_with_invalid_phone.errors[:phone_number], "should be a valid mpesa number"
  end  
  test 'password is strong' do  	  	
  	@user_with_weak_password=build_stubbed(:user_with_weak_password)  	
  	refute @user_with_weak_password.valid?  	
  	refute_empty @user_with_weak_password.errors[:password], "password should have minimum of 8 chars"  	
  end
  test 'account is created on user creation' do    
    
    assert_difference('Account.count',1) do      
      @user=create(:user)
      # @user.accounts.create!(attributes_for(:account))      
    end
  end
end
