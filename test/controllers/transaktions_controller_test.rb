require 'test_helper'

class TransaktionsControllerTest < ActionDispatch::IntegrationTest
	def setup
		@agent=build_stubbed(:agency)
		@user=build_stubbed(:user)
		@amount=1000
	end
  test "deposit" do
  	# binding.pry
  	 post deposit_path, params: {data: {amount: @amount, phone: @user.phone_number}}
  	 assert_response 200
  end
  test "withdraw" do
  	# skip
  	# post transactions_withdraw_url, params: {data: {amount: @amount, phone: @user.phone_number, agent_number: @agent.id}}
  	# assert_response 200
  end
  test "send money" do
  	# skip
  	# current_user=User.first
  	# post send_money_index_url, params: {data: {amount: @amount, recipient: @user.id}}
  	# # binding.pry
  	# assert_response 200
  end
end
