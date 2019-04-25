require 'test_helper'

class StatementControllerTest < ActionDispatch::IntegrationTest
  include ActionMailer::TestHelper
	test "send Statement" do
		@user=create(:user)
		account=create(:account, :for_user)		
		5.times do
			create(:transaktion, account: account)
		end
		# binding.pry		
		get statement_path(account_id: account.id), params: {email: @user.email, start_date: account.created_at, end_date: Time.now
		}
		assert_response 200
	end
end
