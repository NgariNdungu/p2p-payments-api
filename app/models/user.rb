class User < ApplicationRecord
  has_many :accounts, as: :owner
  has_one :agency
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :phone_number, presence: true, uniqueness: true, length: {is: 10}, format: {with: /07[^35678]+[0-9]+/}
  validates :full_name, presence: true
  after_create :create_account

  private
  def create_account  	
  	accounts.create
  end
end
