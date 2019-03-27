class MyValidator < ActiveModel::Validator
  def validate(agency_account)
    @exists = Account.find_by_owner_id(agency_account.owner_id).present?
    agency_account.errors.add(:account, 'agency can only own one account') if agency_account.owner_type == 'Agency' && @exists
  end
end

class Account < ApplicationRecord
  include ActiveModel::Validations
  validates_with MyValidator
  belongs_to :owner, polymorphic: true
  has_many :transaktions
end
