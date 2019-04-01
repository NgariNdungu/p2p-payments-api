FactoryBot.define do
  factory :user do
    sequence(:email, 'a') { |c| "user#{c}@domain.com" }
    password { 'notapassword' }
    sequence(:phone_number, '0701234567')
    full_name { 'first user' }
    factory :user_with_invalid_phone do
      phone_number { '0736234234' }
    end
    factory :user_with_weak_password do
      password { 'qwerty' }
    end
    factory :loaded_user do
      transient do
        balance { 1_000 }
      end
      after(:create) do |user, values|
        user.accounts.first.update(balance: values.balance)
      end
    end
  end
end
