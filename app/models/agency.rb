# frozen_string_literal: true

class Agency < ApplicationRecord
  belongs_to :user
  has_one :account, as: :owner

  validates :location, :business_name, presence: true

  # OPTIMIZE: configuration value for starting agent account balance
  # prefer call back notation
  after_create :create_default_account

  def deposit(recipient:, amount:)
    Account.transfer(from: account, to: recipient, amount: amount, trans_type: 'deposit')
  end

  private

  def create_default_account
    create_account(balance: 100_000)
  end
end
