require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

Bundler.require(:default, Rails.env)

module AppDevAcademy
  class Application < Rails::Application
    
    # Disable automatic generation for TestUnit, JS, CSS files and helpers
    config.generators do |g|
      g.test_framework  nil, fixture: false
      g.fixture_replacement :factory_girl
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end
    
    # Configure assets pipeline to properly handle CKEditor assets
    config.autoload_paths    += %w( #{config.root}/app/models/ckeditor )
    config.assets.precompile += Ckeditor.assets
    config.assets.precompile += %w( ckeditor/* )
    
    # Very strange stuff, used this line to mute DEPRECATION WARNING 
    config.active_record.raise_in_transactional_callbacks = true
  end
end