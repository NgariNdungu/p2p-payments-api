# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transaktions

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validate :agency_already_has_an_account, on: :create

  def update_balance(amount)
    (self.balance += amount).tap { |balance| update!(balance: balance) }
  rescue ActiveRecord::RecordInvalid
    raise ActiveRecord::Rollback
  end

  # Avoid variable names of paramter names that might be rails key words like type
  # maybe you could use tran_type
  def self.transfer(from:, to:, amount:, type: 'transfer')
    debit_account = find_or_set_account(from)
    credit_account = find_or_set_account(to)
    # casting the amount my lead to bugs here . e.g "1ooo".to_i is not 1000
    # and waht s "money.to_i" SO in the first plase make sure the input is ok when
    # being submitted
    amount = amount.to_f
    common = {
      trans_set: next_trans_set,
      amount: amount
    }
    # The below needs to be simpler to be understandable eaier
    debit_trans = common.merge(
      trans_type: type != 'transfer' ? type : 'debit',
      balance: debit_account.update_balance(-amount)
    )
    credit_trans = common.merge(
      trans_type: type != 'transfer' ? type : 'credit',
      balance: credit_account.update_balance(+amount)
    )
    # Put thte transaction in the class where the lock is happening in this case Account
    # deconstruct the transaction. The .save calls the  trancation. I am not sure this will work.
    # witr a test to test failuere and see
    # Th transaction shoud ideally be onthe object to not a class method
    # you should create in tranaction. othersise it does not work. You should build
    Account.transaction do
      debit_account.transaktions.build(debit_trans)
      credit_account.transaktions.build(credit_trans)
      # then save the account to make sure the transaction runs
    end
  end

  def self.next_trans_set
    Transaktion.last ? Transaktion.last.trans_set.next : 'AAAA0001'
  end

  def self.find_or_set_account(account)
    return account if account.is_a? Account

    User.find_by(phone_number: account.to_s).try(:account) ||
      Agency.find_by(id: account).account
  end

  private

  def agency_already_has_an_account
    errors.add(:agency, 'can only have one account') if
      owner_type == 'Agency' && Agency.find(owner_id).account
  end
end
