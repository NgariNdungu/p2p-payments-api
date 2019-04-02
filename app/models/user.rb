class User < ApplicationRecord
  has_one :account, as: :owner
  has_one :agency
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :phone_number, presence: true, uniqueness: true, length: {is: 10}, format: {with: /07[^35678]+[0-9]+/}
  validates :full_name, presence: true
  after_create :create_account

 

  def send_money(to:, amount:)
    to_account = User.find_by(phone_number:to).id
    Account.transfer(to: to_account,from: self.account.id, amount: amount)
  end

  def withdraw(agent:, amount:)
    agent_account = Agency.find(agent)
    Account.transfer(to: agent_account, from: self.account.id, amount: amount)
  end

end
