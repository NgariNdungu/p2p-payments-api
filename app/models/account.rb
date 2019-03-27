class Account < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :transaktions

  validate :agency_already_has_an_account, on: :create

  private

  def agency_already_has_an_account
    errors.add(:agency, 'can only have one account') if
      owner_type == 'Agency' && Agency.find(owner_id).account
  end
end
