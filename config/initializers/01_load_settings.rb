begin
  SETTINGS = YAML.load(ERB.new(File.read("#{Rails.root}/config/settings.yml")).result)[Rails.env]
rescue
  SETTINGS = YAML.load(ERB.new(File.read("#{Rails.root}/config/settings.heroku.yml")).result)[Rails.env]
end