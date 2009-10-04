ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'factories'

def not_in_editor?
  ['TM_MODE', 'EMACS', 'VIM'].all? { |k| !ENV.has_key?(k) }
end

Mocha::Configuration.prevent(:stubbing_method_unnecessarily)
Mocha::Configuration.prevent(:stubbing_non_existent_method) 

Micronaut.configure do |config|
  config.formatter = :progress
  config.mock_with :mocha
  config.filter_run :focused => true
  config.alias_example_to :fit, :focused => true
  config.rails.enable_reasonable_defaults!
end
