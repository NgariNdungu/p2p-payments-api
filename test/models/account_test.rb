# frozen_string_literal: true

require 'test_helper'

class AccountTest < ActiveSupport::TestCase
  # setup do
  #   @user = create(:user, email: 'her@email.com', password: 'herpassword', phone_number: '0712345678', full_name: 'her full_name')
  # end

  # test 'Should allow users to own more than one account' do
  #   assert_difference('Account.count') do
  #     create(:account, owner: @user)
  #   end
  # end

  test 'user can have multiple account' do
    user = create(:user)
    user.accounts.build(attributes_for(:account))
    assert user.valid?
  end

  test 'Should delete account ' do
    account = create(:account, owner: @user)
    assert_difference('Account.count', -1) do
      account.destroy
    end
  end

  # test 'should create transactions' do
  #   account = create(:account, owner: @user)
  #   assert_difference('Transaktion.count', 2) do
  #     account.transfer(**(attributes_for :transaktion), to: Account.first.id)
  #   end
  # end

  # test 'transaction should alter balance' do
  #   account = create(:account, owner: @user)
  #   account.transfer(**(attributes_for :transaktion), to: Account.first.id)
  #   assert_not_equal account.balance, account.reload.balance
  # end

  test 'transfer class method' do
    to_account = create(:account)
    from_account = create(:account, balance: 10_000)
    transfer_amount = 100
    assert_difference 'to_account.balance', transfer_amount do
      assert_difference 'from_account.balance', -transfer_amount do
        assert_difference 'Transaktion.count', 2 do
          Account.transfer(to: to_account.user.mobile_no, from: from_account.user.mobile_no, amount: transfer_amount)
        end
      end
    end
  end

  test 'cannot transfer if user does not have enough balance' do
    skip
  end
end
