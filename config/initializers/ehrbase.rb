class EHRbase
  class << self
    def yaml
      @yaml ||= YAML.load(File.read("#{Rails.root}/config/ehrbase.yml"))[Rails.env]
    end

    def yaml=(yaml)
      @yaml = YAML.load(yaml)[Rails.env]
    end

    def scheme
      yaml['scheme']
    end

    def host
      yaml['host']
    end

    def port
      yaml['port']
    end

    def path_prefix
      yaml['path_prefix']
    end

    def url
      yaml['url'] || "#{scheme}://#{host}:#{port}/#{path_prefix}"
    end

    def auth
      yaml['auth']
    end

    def username
      yaml['username']
    end

    def password
      yaml['password']
    end
  end
end


