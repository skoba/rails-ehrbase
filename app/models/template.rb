require 'httpclient'

class Template
  include Base

  class << self
    def post(opt)
      Base.connection.post('definition/template/adl1.4',
                           opt,
                           'Content-Type' => 'application/xml')
    end
    
    def get_list
      JSON.parse Base.connection.get('definition/template').body
    end
  end
end
