class Agency < ApplicationRecord
  belongs_to :user
  has_one :account, as: :owner
  validates :location, :name, presence: true
end
