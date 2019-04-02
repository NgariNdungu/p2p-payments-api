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

  def self.transfer(from:, to:, amount:, type: 'transfer')
    debit_account = find_or_set_account(from)
    credit_account = find_or_set_account(to)
    common = {
      trans_set: next_trans_set,
      amount: amount
    }
    ActiveRecord::Base.transaction do
      debit_account.transaktions.create(common.merge(
        trans_type: type != 'transfer' ? type : 'debit',
        balance: debit_account.update_balance(-amount)
        ))
      credit_account.transaktions.create(common.merge(
        trans_type: type != 'transfer' ? type : 'credit',
        balance: credit_account.update_balance(+amount)
      )) 
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
