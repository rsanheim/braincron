require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

Rake::Task[:default].clear

if RUBY_VERSION < "1.9"
  task :default => ["cucumber", "spec:coverage"]
else
  task :default => ["spec:all"]
end