require 'httpclient'

class Person < ApplicationRecord
  before_save do
    ehrbaseclient = HTTPClient.new(base_url: EHRbase['url'], user: 'ehrbase', password: 'SuperSecretPassword')
    res = ehrbaseclient.post('ehr')
    self.ehr_id = res.headers['ETag'][1..-2]
  end
end
