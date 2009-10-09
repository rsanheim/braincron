namespace :producer do
  desc "Run the Producer, publishing an reminders ready for processing"
  task :run => :environment do
    Producer.run
  end
end