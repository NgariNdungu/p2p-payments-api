class Agency < ApplicationRecord
  belongs_to :user
  has_one :account, as: :owner

  validates :location, :business_name, presence: true

  # OPTIMIZE: configuration value for starting agent account balance
  after_create do
    create_account(balance: 100_000)
  end

  def deposit(recipient:, amount:)
    Account.transfer(from: account, to: recipient, amount: amount, type: 'deposit')
  end
end
