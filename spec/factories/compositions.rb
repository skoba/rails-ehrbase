FactoryBot.define do
  factory :composition do
    body do
      File.read(
        Rails.root.join('spec',
                        'factories',
                        'composition_sample_body.json')
      )
    end
    association :ehr,
                factory: :ehr,
                strategy: :create
  end
end
