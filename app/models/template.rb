require 'httpclient'

class Template
  include Base

  class << self
    def post(opt)
      Base.ehrbase_connection.post('definition/template/adl1.4',
                           opt,
                           'Content-Type' => 'application/xml')
    end
    
    def all
      list = JSON.parse(Base.ehrbase_connection.get('definition/template/adl1.4').body) || []
    end

    def create(params)
      opt = File.read(params[:file])
      response =  self.post(opt)
    end
  end
end
