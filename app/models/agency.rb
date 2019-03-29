class Agency < ApplicationRecord
  belongs_to :user
  has_one :account, as: :owner

  validates :location, :business_name, presence: true

  after_create :create_account
end
