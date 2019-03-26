FactoryBot.define do
  factory :user do
    email { 'user@domain.com' }
    password { 'notapassword' }
    phone_number { '0701234567' }
    full_name { 'first user' }
  end
end
