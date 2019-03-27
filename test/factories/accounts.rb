FactoryBot.define do
  factory :account do
    balance {0}
    trait :for_agency do
      association(:owner, factory: :agency)
      balance { 1000 }
    end

    trait :for_user do
      association(:owner, factory: :user)

      balance {0}
    end
  end
end
