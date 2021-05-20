require 'active_model'
require 'httpclient'

module Base
  extended ActiveSupport::Concern

  class << self
    def ehrbase_connection
      @ehrbase_con ||= HTTPClient.new(base_url: EHRbase.url,
                              user: EHRbase.username,
                              password: EHRbase.password)
    end

    alias_method :connection, :ehrbase_connection

    def orca_connection
      @orca_con ||= HTTPClient.new(base_url: "http://localhost:8000",
                                   user: "ormaster",
                                   password: "ormaster")
    end

    def termserv_connection
      @termserv_con ||= HTTPClient.new(base_url: "http://localhost:3333")
    end
  end
end
