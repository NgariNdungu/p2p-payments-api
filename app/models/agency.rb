class Agency < ApplicationRecord
  belongs_to :user

  validates :location, :business_name, presence: true
end
