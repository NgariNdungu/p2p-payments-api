# frozen_string_literal: true

class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transaktions

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validate :agency_already_has_an_account, on: :create

  # Get transaction for a specific account for the last 24hours
  def self.get_report(account)
    reports = []
    report = {}
    transactions = Transaktion.trasactions_for_last_24_hours.where(account: account)
    transactions.each do |transaction_object|
      report[:type] = transaction_object.trans_type
      report[:amount] = transaction_object.amount
      report[:time] = transaction_object.created_at
      report[:transaction_code] = transaction_object.trans_set
      reports << report
    end
  end

  def self.transfer(from:, to:, amount:, trans_type: nil)
    debit_account = find_or_set_account(from)
    credit_account = find_or_set_account(to)
    debit_account.lock!
    credit_account.lock!
    transaction_params = trans_params(debit_account, credit_account,
                                      amount, trans_type)
    Account.transaction do
      debit_account.transaktions.build(transaction_params[:debit])
      credit_account.transaktions.build(transaction_params[:credit])
      credit_account.save!
      debit_account.save!
      { debit: debit_account.transaktions.last,
        credit: credit_account.transaktions.last }
    end
  rescue ActiveRecord::RecordInvalid
    # TODO: return and use the relevant error on failed transactions
    debit_account.errors if debit_account.errors.present?
  end

  def self.next_trans_set
    Transaktion.last ? Transaktion.last.trans_set.next : 'AAAA0001'
  end

  def self.find_or_set_account(account)
    return account if account.is_a? Account

    User.find_by(phone_number: account.to_s).try(:account) ||
      Agency.find_by(id: account).account
  end

  def self.trans_params(debit_account, credit_account, amount, trans_type)
    common = {
      trans_set: next_trans_set,
      amount: amount
    }
    {
      debit: common.merge(
        trans_type: trans_type || 'debit',
        balance: debit_account.balance -= amount
      ),
      credit: common.merge(
        trans_type: trans_type || 'credit',
        balance: credit_account.balance += amount
      )
    }
  end

  private

  def agency_already_has_an_account
    errors.add(:agency, 'can only have one account') if
      owner_type == 'Agency' && Agency.find(owner_id).account
  end
end
