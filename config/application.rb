require File.expand_path('../boot', __FILE__)

require 'action_controller/railtie'
require 'active_support'
require 'action_mailer/railtie'
require 'mongoid/railtie'
require 'sprockets/railtie'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module GDZLLA
  class Application < Rails::Application
    config.middleware.insert 0, 'Rack::Deflater'
    config.middleware.insert_before('Rack::Lock', 'Rack::Rewrite') do
      r301 %r{(.+)/$}, '$1'
    end
    config.time_zone = 'America/New_York'
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.active_support.escape_html_entities_in_json = true
    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.assets.enabled = true
    config.assets.version = '1.0'
  end
end
