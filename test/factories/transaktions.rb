FactoryBot.define do
  factory :transaktion do
    association :account, :for_user
    trans_set { "MyString" }
    balance { 1.5 }
    trans_type { "MyString" }
    amount { 1.5 }
  end
end
