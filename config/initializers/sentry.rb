if ENV['RAVEN_DSN']
  require 'raven'

  Raven.configure do |config|
    config.dsn = ENV['RAVEN_DSN']
  end
end
