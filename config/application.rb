require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

Bundler.require(:default, Rails.env)

module Consigliere
  class Application < Rails::Application

    config.generators do |g|
        g.test_framework  nil, :fixture => false
    end

  end
end
