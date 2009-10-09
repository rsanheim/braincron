require "rosetta_queue"

config_file = Rails.root.join("config", "activemq.yml")
QUEUE_CONFIG = YAML.load_file(config_file).fetch(Rails.env) do
   raise(IndexError, "No config values found for #{Rails.env} in #{config_file}")
end

RosettaQueue::Destinations.define do |queue|
  queue.map :requests, "/braincron/zeus_requests"
  queue.map :results, "/braincron/zeus_results"
  queue.map :exceptions, "/braincron/zeus_exceptions"
end

RosettaQueue::Adapter.define do |a|
  a.user = QUEUE_CONFIG["user"]
  a.password = QUEUE_CONFIG["password"]
  a.host = QUEUE_CONFIG["host"]
  a.port = QUEUE_CONFIG["port"]
  a.type = QUEUE_CONFIG["type"]
end

RosettaQueue.logger = Logger.new(Rails.root.join("log", "queue_#{Rails.env}.log"))
RosettaQueue.logger.formatter = SyslogFormatter.new

RosettaQueue::Filters.define do |filter_for|
  filter_for.receiving { |message| ActiveSupport::JSON.decode(message) }
  filter_for.sending { |hash| hash.to_json }
end

