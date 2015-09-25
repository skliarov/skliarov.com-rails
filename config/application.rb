require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(:default, Rails.env)

module Consigliere
  class Application < Rails::Application
    
    config.generators do |g|
      g.test_framework  nil, fixture: false
      g.stylesheets false
      g.javascripts false
      g.helper      false
    end
    
    config.autoload_paths += %W(#{config.root}/app/models/ckeditor)
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w(ckeditor/*)
    
    config.active_record.raise_in_transactional_callbacks = true
  end
end