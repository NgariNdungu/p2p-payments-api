FactoryBot.define do
  factory :agency do
    business_name { "Well chosen" }
    location { "kwa stima" }
    user 
    factory :missing_user do
      user { 0 }
    end
  end
end
