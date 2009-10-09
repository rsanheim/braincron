namespace :spec do
  begin
    gem "spicycode-micronaut"
    require "micronaut"
    require "micronaut/rake_task"
  
    desc "Run all specs using rcov"
    Micronaut::RakeTask.new :coverage => ["db:test:prepare"] do |t|
      t.pattern = "spec/**/*_spec.rb"
      t.rcov = true 
      t.rcov_opts = %[-Ispec --exclude "features/*,gems/*,lib/authenticated*,db/*,/Library/Ruby/*,config/*" --rails --text-summary --sort coverage --html]
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

