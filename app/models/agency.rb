# frozen_string_literal: true

class Agency < ApplicationRecord
  belongs_to :user
  has_one :account, as: :owner

  validates :location, :business_name, presence: true

  # OPTIMIZE: configuration value for starting agent account balance
  # prefer call back notation
  after_create :create_default_account

  # OPTIMIZE: refactor how parameters are handled
  def deposit(txn_parameters)
    dep_params = txn_parameters.slice(:amount, :phone)
    Account.transfer(from: account, to: dep_params[:phone],
                     amount: dep_params[:amount], trans_type: 'deposit')
  end

  private

  def create_default_account
    create_account(balance: 100_000)
  end
end
