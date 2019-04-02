# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  test 'user cannot have multiple accounts' do
    # ActiveRecord::RecordNotSaved - expected 
    suppress(ActiveRecord::RecordNotSaved) do
      user = create(:user)
      user.build_account(attributes_for(:account))
      refute user.valid?
    end
  end

  test 'transfer class method' do
    to_account = create(:user).account
    from_account = create(:loaded_user, balance: 10_000).account
    transfer_amount = 100
    assert_difference 'to_account.reload.balance', transfer_amount do
      assert_difference 'from_account.reload.balance', -transfer_amount do
        assert_difference 'Transaktion.count', 2 do
          Account.transfer(to: to_account, from: from_account,
                           amount: transfer_amount)
        end
      end
    end
  end

  test 'cannot transfer if user does not have enough balance' do
    to_account = create(:user).account
    from_account = create(:loaded_user, balance: 100).account
    transfer_amount = 1000
    assert_no_difference 'to_account.reload.balance' do
      assert_no_difference 'from_account.reload.balance' do
        assert_no_difference 'Transaktion.count' do
          Account.transfer(to: to_account, from: from_account,
                           amount: transfer_amount)
        end
      end
    end
  end
end
