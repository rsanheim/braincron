ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'factories'
require 'support/clearance'
require 'log_buddy'
LogBuddy.init

def not_in_editor?
  ['TM_MODE', 'EMACS', 'VIM'].all? { |k| !ENV.has_key?(k) }
end

Mocha::Configuration.prevent(:stubbing_method_unnecessarily)
Mocha::Configuration.prevent(:stubbing_non_existent_method) 

Micronaut.configure do |config|
  config.color_enabled = true
  config.formatter = :progress
  config.mock_with :mocha
  config.filter_run :focused => true
  config.alias_example_to :fit, :focused => true
  config.include Clearance::Shoulda::Helpers
  
  config.rails.enable_reasonable_defaults!
end
