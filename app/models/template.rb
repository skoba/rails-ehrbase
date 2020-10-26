require 'httpclient'

class Template
  def self.post(opt)
    self.ehrbaseclient.post('definition/template/adl1.4', opt, 'Content-Type' => 'application/xml')
  end

  def self.get_list
    JSON.parse self.ehrbaseclient.get('definition/template').body
  end

  private
  def self.ehrbaseclient
    ehrbaseclient = HTTPClient.new(base_url: EHRbase.url, user: EHRbase.username, password: EHRbase.password)
  end
end
