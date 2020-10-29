require 'httpclient'

class Person < ApplicationRecord
  include Base

  before_save do
    res = Base.connection.post('ehr')
    self.ehr_id = res.headers['ETag'][1..-2]
  end
end
