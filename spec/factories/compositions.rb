FactoryBot.define do
  factory :composition do
    #    body { }
    association :ehr,
                factory: :ehr,
                strategy: :create
  end
end
