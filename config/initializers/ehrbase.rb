EHRbase = YAML.load(
  File.read("#{Rails.root}/config/ehrbase.yml"))[Rails.env]
