class UserResource < JSONAPI::Resource
  attributes :full_name, :email, :phone_number, :password
  def fetchable_fields
    super - [:password]
  end
end
