FactoryBot.define do
  factory :transaktion do
    credit_account { 1 }
    debit_account { 1 }
    ca_balance { 1.5 }
    da_balance { 1.5 }
    account { nil }
  end
end
