class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transaktions

  validate :agency_already_has_an_account, on: :create

  def self.transfer(from:, to:, amount:)
    debit_account = find(from)
    credit_account = find(to)
    debit_account.transaktions.create(
      trans_type: 'debit',
      trans_set: next_trans_set,
      amount: amount
    )
    credit_account.transaktions.create(
      trans_type: 'credit',
      trans_set: next_trans_set,
      amount: amount
    )
  end

  def transfer(**args)
    Account.transfer(from: id, to: args[:to], amount: args[:amount])
  end

  private

  def self.next_trans_set
    Transaktion.last ? Transaktion.last.trans_set.next : 'AAAA0001'
  end

  def agency_already_has_an_account
    errors.add(:agency, 'can only have one account') if
      owner_type == 'Agency' && Agency.find(owner_id).account
  end
end
