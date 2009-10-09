# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'

namespace :spec do
  begin
    gem "spicycode-micronaut"
    require "micronaut"
    require "micronaut/rake_task"
  
    desc "Run all specs using rcov"
    Micronaut::RakeTask.new :coverage => ["db:test:prepare"] do |t|
      t.pattern = "spec/**/*_spec.rb"
      t.rcov = true 
      t.rcov_opts = %[-Ispec --exclude "features/*,gems/*,lib/authenticated*,db/*,/Library/Ruby/*,config/*" --rails --text-summary --sort coverage --aggregate coverage.data]
    end
  
    desc "Run all specs"
    Micronaut::RakeTask.new :all => ["db:test:prepare"] do |t|
      t.pattern = "spec/**/*_spec.rb"
      t.ruby_opts = ["-Ispec"]
    end
    task :default => :all
  rescue LoadError => e
    puts "Micronaut not installed - spec tasks not available"
  end
end

Rake::Task[:default].clear

if RUBY_VERSION < "1.9"
  task :default => ["cucumber", "spec:coverage"]
else
  task :default => ["spec:all"]
end