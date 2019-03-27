class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transaktions
end
