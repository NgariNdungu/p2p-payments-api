class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  has_one :account, as: :owner, dependent: :destroy
  has_one :agency
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
  validates :phone_number, presence: true, uniqueness: true, length: { is: 10 },
                           format: { with: /07[^35678]+[0-9]+/ }
  validates :full_name, presence: true
  after_create :create_account

  def send_money(txn_parameters)
    send_params = txn_parameters.slice(:phone, :amount)
    Account.transfer(from: account, to: send_params[:phone],
                     amount: send_params[:amount], trans_type: 'transfer')
  end

  def withdraw(txn_parameters)
    withdraw_params = txn_parameters.slice(:amount, :agent_number)
    Account.transfer(from: account, to: withdraw_params[:agent_number],
                     amount: withdraw_params[:amount], trans_type: 'withdrawal')
  end

  def get_report(account)
    Account.get_report(account: account)
  end

  def logout(payload, user)
    User.revoke_jwt(payload, user) unless User.jwt_revoked?(payload, user)
  end

end
