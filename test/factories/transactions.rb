FactoryBot.define do
  factory :transaction do
    credit_account { 1 }
    debit_account { 1 }
    ca_balance { 1.5 }
    da_balance { 1.5 }
    account { nil }
  end
end
