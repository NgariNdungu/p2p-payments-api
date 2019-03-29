# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'user is valid' do
    @user = build(:user)
    assert @user.valid?
  end

  test 'phone number is of correct format' do
    @user_with_invalid_phone = build_stubbed(:user_with_invalid_phone)
    refute @user_with_invalid_phone.valid?
    refute_empty @user_with_invalid_phone.errors[:phone_number], 'should be a valid mpesa number'
  end

  test 'password is strong' do
    @user_with_weak_password = build_stubbed(:user_with_weak_password)
    refute @user_with_weak_password.valid?
    refute_empty @user_with_weak_password.errors[:password], 'password should have minimum of 8 chars'
  end

  test 'account is created on user creation' do
    assert_difference('Account.count', 1) do
      @user = create(:user)
    end
  end

  test 'deposit' do
    agent = create(:agent)
    user = create(:user)
    deposit_amount = 1_000
    assert_difference 'user.defaut_account', deposit_amount do
      assert_difference 'agent.account', -deposit_amount do
        agent.deposit(amount: deposit_amount, recipient: user.mobile_no)
      end
    end
  end

  test 'withdraw' do
    agent = create(:agent)
    user = create(:user)
    withdraw_amount = 1_000
    assert_difference 'user.defaut_account', -withdraw_amount do
      assert_difference 'agent.account', withdraw_amount do
        agent.withdraw(amount: withdraw_amount, recipient: user.mobile_no)
      end
    end
  end

  test 'send money' do
    sender = create(:loaded_user, balance: 10_000)
    recipient = create(:user)
    sent_amount = 1_000
    assert_difference 'sender.defaut_account', -sent_amount do
      assert_difference 'recipient.defaut_account', sent_amount do
        sender.send_money(amount: sent_amount, to: recipient.mobile_no)
      end
    end
  end

  test 'cannot deposit or withdraw if not an agent' do
    skip
  end
end
