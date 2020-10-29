module Base
  extended ActiveSupport::Concern

  class << self
    def connection
      @con ||= HTTPClient.new(base_url: EHRbase.url,
                              user: EHRbase.username,
                              password: EHRbase.password)
    end
  end
end
