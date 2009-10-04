# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


task :cleanup_rcov_files do
  rm_rf 'coverage.data'
end

namespace :spec do
  gem "spicycode-micronaut"
  require "micronaut"
  require "micronaut/rake_task"
  
  desc "Run all specs using rcov"
  Micronaut::RakeTask.new :coverage => ["db:test:prepare"] do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.rcov = true 
    t.rcov_opts = %[--exclude "features/*,spec/*,gems/*,lib/authenticated*,db/*,/Library/Ruby/*,config/*" --rails --text-summary --sort coverage --aggregate coverage.data]
  end
  
  desc "Run all specs"
  Micronaut::RakeTask.new :all => ["db:test:prepare"] do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.ruby_opts = ["-Ispec"]
  end
  task :default => :all
end

Rake::Task[:default].clear
task :default => "spec:all"