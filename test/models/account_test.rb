# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase

  test 'user can have multiple account' do
    user = create(:user)
    user.accounts.build(attributes_for(:account))
    assert user.valid?
  end

  test 'transfer class method' do
    user = create(:user)
    to_account = user.accounts.create(attributes_for(:account))
    from_account = user.accounts.create(attributes_for(:account, balance: 10_000))
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
    user = create(:user)
    to_account = user.accounts.create(attributes_for(:account))
    from_account = user.accounts.create(attributes_for(:account, balance: 100))
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
