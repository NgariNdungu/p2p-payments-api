class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :account, as: :owner
  has_one :agency
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  validates :phone_number, presence: true, uniqueness: true, length: { is: 10 },
                           format: { with: /07[^35678]+[0-9]+/ }
  validates :full_name, presence: true
  after_create :create_account


  def send_money(to:, amount:)
    Account.transfer(from: account, to: to,
                     amount: amount, type: 'transfer')
  end

  def withdraw(agent:, amount:)
    Account.transfer(from: account, to: agent,
                     amount: amount, type: 'withdrawal')
  end

end
