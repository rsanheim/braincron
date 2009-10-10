require 'active_support/memoizable'
require 'rosetta_queue'

class Producer
  def self.logger
    logger = Logger.new(Rails.root.join("log", "producer.log"))
    logger.formatter = SyslogFormatter.new
    logger.level = Logger::DEBUG
    logger
  end
  
  class << self
    extend ActiveSupport::Memoizable
    memoize :logger
  end

  def self.run
    logger.info { "#{self.name} started..."}
    reminders = Reminder.need_processing
    logger.info { "Found #{reminders.size} reminders that need processing" }
    reminders.each do |reminder|
      publish(reminder)
    end
  end
  
  def self.publish(reminder)
    message = reminder.to_hash
    logger.debug { "Sending reminder: #{reminder.id} msg: #{message.inspect}"}
    if Chatterbox.handle_notice(message)
      reminder.processed!
    end
  end
end
