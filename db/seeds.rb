# coding: utf-8
require 'faker'

10.times do
  person = Person.create(name: Faker::Name.name)
  20.times do
    Monshin.create(ehr_id: person.ehr_id,
                   start_time: Time.now,
                   author: Faker::Name.name,
                   height_length: Faker::Number.normal(mean: 162.5, standard_deviation: 18.4),
                   height_length_unit: "cm",
                   weight: Faker::Number.normal(mean: 61.9, standard_deviation: 17.6),
                   weight_unit: "kg",
                   temperature: Faker::Number.normal(mean: 36.89, standard_deviation: 0.41),
                   temperature_unit: "Cel",n
                   confounding_factors: ["着衣",'脱衣','軽装'].sample,
                   presenting_problem: ["頭痛",'胸痛','腹痛'].sample,
                   story: ["3日前から頭痛。激しくなり来院",'突然発症'].sample,
                   symptom_sign_name: ["頭痛",'胸痛','腹痛'].sample)
  end
end
