FactoryBot.define do
  factory :account do
    balance { 1 }
    is_agent { false }
    user { nil }
  end
end
