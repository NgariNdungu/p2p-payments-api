# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase

  # test 'user is valid' do
  #   @user = build(:user)
  #   assert @user.valid?
  # end

  # test 'phone number is of correct format' do
  #   @user_with_invalid_phone = build_stubbed(:user_with_invalid_phone)
  #   refute @user_with_invalid_phone.valid?
  #   refute_empty @user_with_invalid_phone.errors[:phone_number], 'should be a valid mpesa number'
  # end

  # test 'password is strong' do
  #   @user_with_weak_password = build_stubbed(:user_with_weak_password)
  #   refute @user_with_weak_password.valid?
  #   refute_empty @user_with_weak_password.errors[:password], 'password should have minimum of 8 chars'
  # end

  test 'deposit' do
    agent = create(:agency)
    user = create(:user)
    deposit_amount = 1_000
    assert_difference 'user.reload.account.balance', deposit_amount do
      assert_difference 'agent.account.balance', -deposit_amount do
        agent.deposit(amount: deposit_amount, recipient: user.phone_number)
      end
    end
  end

  test 'withdraw' do
    agent = create(:agency)
    user = create(:loaded_user, balance: 1_000)
    withdraw_amount = 1_000
    assert_difference 'user.account.balance', -withdraw_amount do
      assert_difference 'agent.account.balance', withdraw_amount do
        user.withdraw(amount: withdraw_amount, agent: agent.id)
        agent.reload
      end
    end
  end

  test 'send money' do
    sender = create(:loaded_user, balance: 10_000)
    recipient = create(:user)
    sent_amount = 1_000
    assert_difference 'sender.account.balance', -sent_amount do
      assert_difference 'recipient.reload.account.balance', sent_amount do
        sender.send_money(amount: sent_amount, to: recipient.phone_number)
      end
    end
  end

  test 'cannot deposit or withdraw if not an agent' do
    skip
  end
end
