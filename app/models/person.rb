class Person < ApplicationRecord
  before_create do |person|
    client = HTTPClient.new
    request = client.post("#{EHRbase['url']}/ehr")
    ehr_id = request.headers['ETag']
    person.ehr_id = ehr_id
  end
end
