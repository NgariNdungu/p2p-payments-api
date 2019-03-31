class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transaktions

  validate :agency_already_has_an_account, on: :create

  # TODO: accept either an object or id
  def transfer(**args)
    Account.transfer(from: id, to: args[:to], amount: args[:amount])
  end

  def update_balance(amount)
    (self.balance += amount).tap { |balance| update(balance: balance) }
  end

  def self.transfer(from:, to:, amount:)
    debit_account = find(from)
    credit_account = find(to)
    common = {
      trans_set: next_trans_set,
      amount: amount
    }
    debit_account.transaktions.create(common.merge(
      trans_type: 'debit',
      balance: debit_account.update_balance(-amount)
      ))
      credit_account.transaktions.create(common.merge(
        trans_type: 'credit',
        balance: credit_account.update_balance(+amount)
      )) 
  end

  def self.next_trans_set
    Transaktion.last ? Transaktion.last.trans_set.next : 'AAAA0001'
  end

  private

  def agency_already_has_an_account
    errors.add(:agency, 'can only have one account') if
      owner_type == 'Agency' && Agency.find(owner_id).account
  end
end
