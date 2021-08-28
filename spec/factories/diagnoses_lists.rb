# coding: utf-8
FactoryBot.define do
  factory :diagnosis_list do
    author { 'Shinji Kobayashi' }
    sart_date { '2021-05-21' }
    end_date { '2021-05-28' }
    diagnosis_name  { '急性骨髄性白血病' }
    diagnosis_code { "2050003" }
    diagnosis_terminology { 'Syoubyoumei Master' }
    ehr
  end
end
