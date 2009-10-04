config.cache_classes = true
config.whiny_nils = true

config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_loading            = true
config.action_controller.allow_forgery_protection    = false
config.action_mailer.delivery_method = :test

config.gem 'mocha'
config.gem 'faker', :version => '>= 0.3.1', :lib => false
config.gem 'relevance-rcov', :lib => false, :source => 'http://gems.github.com', :version => '>= 0.9.0'
config.gem 'spicycode-micronaut', :lib => 'micronaut', :source => "http://gems.github.com", :version => '>= 0.3.0'
config.gem 'spicycode-micronaut-rails', :lib => 'micronaut-rails', :source => "http://gems.github.com", :version => '>= 0.3.2'
config.gem 'thoughtbot-factory_girl', :lib => 'factory_girl', :source => "http://gems.github.com", :version => ">= 1.2.1"