require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @agent = create(:agency)
    @user = create(:user)
    @amount = 1000
  end

  test 'deposit' do
    sign_in @agent.user
    post deposit_url, params: { data: { amount: @amount, phone: @user.phone_number } }
    assert_response 200
  end

  test 'withdraw' do
    @user.account.update(balance: 2500)
    sign_in @user
    post withdrawal_url, params: {data: {amount: @amount, phone: @user.phone_number, agent_number: @agent.id}}
    assert_response 200
  end

  test 'send money' do
    # skip
    sign_in create(:loaded_user)
    post send_money_url, params: {data: {amount: @amount, recipient: @user.phone_number}}
    assert_response 200
  end
end
