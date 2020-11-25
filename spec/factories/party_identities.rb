FactoryBot.define do
  factory :party_identity do
    name { 'Person name' }
    purpose { 'legal name' }
    party { nil }
  end
end
