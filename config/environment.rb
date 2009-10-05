RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  if RUBY_VERSION >= "1.9"
    config.gem 'antage-postgres', :lib => false
  end
  config.gem "chronic"
  config.gem "thoughtbot-clearance", :lib => 'clearance', :source  => 'http://gems.github.com', :version => '0.8.2'
  config.gem "justinfrench-formtastic", :lib => 'formtastic', :source  => 'http://gems.github.com'
  config.gem "relevance-log_buddy", :lib => false
  config.gem "chatterbox", :source => "http://gemcutter.org"
  config.gem "chatterbox-email", :lib => "chatterbox/email"
  
  config.frameworks -= [:active_resource]

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'
end

HOST = "localhost"
DO_NOT_REPLY = "donotreply@example.com"

Chatterbox::Publishers.register do |notice|
  Chatterbox::Email.deliver(notice)
end
