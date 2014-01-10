# coding: utf-8
require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "rails/test_unit/railtie"
require 'sprockets/railtie'


if defined?(Bundler)
  Bundler.require *Rails.groups(:assets => %w(production development test))
end

module SuperHero
  class Application < Rails::Application
    config.time_zone = 'Beijing'
    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    config.mongoid.include_root_in_json = false

    config.assets.enabled = true
    config.assets.version = '1.0'

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end
    
    config.assets.precompile += %w(application.css)
  end
end

I18n.locale = 'zh-CN'



