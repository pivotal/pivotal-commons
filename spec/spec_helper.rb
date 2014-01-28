# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

require 'capybara/accessible'
Capybara.default_driver = :accessible_webkit
Capybara.javascript_driver = :accessible_webkit

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.around(:each, inaccessible: true) do |example|
    Capybara::Accessible.skip_audit { example.run }
  end
end
