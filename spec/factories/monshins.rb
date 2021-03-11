# coding: utf-8

FactoryBot.define do
  factory :monshin do
    author { "Shinji Kobayashi" }
    height_length { 178.0 }
    height_length_unit { "cm" }
    weight  { 60.2 }
    weight_unit  { "kg" }
    temperature  { 36.2 }
    temperature_unit { "Cel" }
    confounding_factors { "着衣" }
    presenting_problem { "頭痛" }
    story { "3日前から頭痛。激しくなり来院" }
    symptom_sign_name { "頭痛" }
    ehr
  end
end
