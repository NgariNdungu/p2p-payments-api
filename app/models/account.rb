class Account < ApplicationRecord
  belongs_to :user
  has_many :transaktion


  attr_accessor :balance

  private

  def minimum_balance?(balance)
    return balance == 0
  end
end
