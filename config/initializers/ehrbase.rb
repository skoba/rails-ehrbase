#require 'uri'

EHRbase = YAML.load(File.read("#{Rails.root}/config/ehrbase.yml"))[Rails.env]

EHRbase['url'] ||= "#{EHRbase['scheme']}://#{EHRbase['host']}:#{EHRbase['port'].to_s}/#{EHRbase['path']}"

