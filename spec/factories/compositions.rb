FactoryBot.define do
  factory :composition do
    ehr_id { "3399cfdc-c5b5-4786-a12d-2726f1026e8a" }
    body do
      File.read(
        Rails.root.join('spec',
                        'factories',
                        'composition_sample_body.json')
      )
    end
  end
end
