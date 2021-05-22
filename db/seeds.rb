# coding: utf-8
require 'faker'

# [1,2].each do |id|
#   person = Person.create(orca_id: "0000#{id}")
#   20.times do
#     Monshin.create(ehr_id: person.ehr_id,
#                    start_time: Time.now,
#                    author: Faker::Name.name,
#                    height_length: Faker::Number.normal(mean: 162.5, standard_deviation: 18.4).ceil(1),
#                    height_length_unit: "cm",
#                    weight: Faker::Number.normal(mean: 61.9, standard_deviation: 17.6).ceil(1),
#                    weight_unit: "kg",
#                    temperature: Faker::Number.normal(mean: 36.89, standard_deviation: 0.41).ceil(1),
#                    temperature_unit: "Cel",
#                    confounding_factors: ["着衣",'脱衣','軽装'].sample,
#                    presenting_problem: ["頭痛",'胸痛','腹痛'].sample,
#                    story: ["3日前から頭痛。激しくなり来院",'突然殴られたように頭が痛くなった。', '咳が出て止まらない。下痢が激しい'].sample,
#                    symptom_sign_name: ["頭痛",'胸痛','腹痛'].sample)
    
#   end  
# end
[1,2].each do |id|
  person = Person.create(orca_id: "0000#{id}")
  20.times do
    DiagnosesList.create(ehr_id: person.ehr_id,
                         start_date: Time.now.iso8601,
                         end_date: Time.now.iso8601,
                   diagnosis_terminology: 'ICD-10',
#                   version: '2021-Japan',
                   diagnosis_name: '急性骨髄性白血病',
                   diagnosis_code: 'C92.0',
                   author: Faker::Name.name)
  end
end
