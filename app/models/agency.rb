class Agency < ApplicationRecord
  belongs_to :user
  has_one :account, as: :owner

  validates :location, :business_name, presence: true

  after_create :create_account


  def deposit(to:, amount:)
    user_account = User.find_by(phone_number:to).id
    Account.transfer(to: agent_account, from: self.account.id, amount: amount)
  end
end
