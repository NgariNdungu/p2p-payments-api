FactoryBot.define do
  factory :user do  	
    email { 'user@domain.com' }
    password { 'notapassword' }
    phone_number { '0701234567' }
    full_name { 'first user' }
    factory :user_with_invalid_phone do
    	phone_number {'0736234234'}
    end
    factory :user_with_weak_password do
    	password {'qwerty'}
    end
  end
end
