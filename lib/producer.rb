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
    logger.debug { "#{self.name} started..."}
    Reminder.need_processing.each do |reminder|
      publish(reminder)
    end
  end
  
  def self.publish(message)
    logger.debug { "Submitting reminder: #{reminder.id} msg: #{message.inspect}"}
    RosettaQueue::Producer.publish(:requests, message)
  end
end
