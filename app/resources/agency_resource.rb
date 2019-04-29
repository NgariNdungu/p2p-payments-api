class AgencyResource < JSONAPI::Resource
  attributes :business_name, :location

  has_one :user
end
