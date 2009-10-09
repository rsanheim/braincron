require 'rosetta_queue/consumer_managers/base'

module RosettaQueue
  class ThreadedManager < BaseManager

    def initialize
      @threads    = {}
      @running    = true
      @processing = false
      super
    end

    def start
      start_threads
      join_threads
      monitor_threads
    end

    def stop
      stop_threads
    end

  private

    def join_threads
      @threads.each { |thread| thread.join }
    end

    def shutdown_requested
      RosettaQueue.logger.error "got TERM or INT, @running = #{@running} @processing = #{@processing}"
      
      while @threads.any? { |n, t| t.alive? }
        RosettaQueue.logger.info "Calling stop_threads"
        stop_threads
        sleep 5
      end
      # exit
    end
    
    def monitor_threads
      while @running
        trap("TERM") { shutdown_requested }
        trap("INT")  { shutdown_requested }
        
        living = false

        @threads.each { |name, thread| living ||= thread.alive? }
        @processing = @threads.any? { |name, thread| thread[:processing] }
        
        @running = living
        sleep 1
      end

      puts "All connection threads have died..."
      rescue Interrupt=>e
        RosettaQueue.logger.warn("Interrupt received.  Shutting down...")
        puts "\nInterrupt received\n"
      rescue Exception=>e
        RosettaQueue.logger.error("Exception thrown -- #{e.class.name}: #{e.message}")
      ensure
        RosettaQueue.logger.warn("Cleaning up threads...")
        stop_threads
    end

    def start_threads
      @consumers.each do |key, consumer|
        @threads[key] = Thread.new(key, consumer) do |a_key, a_consumer|
          while @running
            begin
              RosettaQueue.logger.info("Threading consumer #{a_key}:#{a_consumer}...")
              Mutex.new.synchronize { a_consumer.receive }
            rescue StopProcessingException=>e
              RosettaQueue.logger.error("#{a_key}: Processing Stopped - receive interrupted")
            rescue Exception=>e
              RosettaQueue.logger.error("#{a_key}: Exception from connection.receive: #{$!}\n" + e.backtrace.join("\n\t"))
            end
            Thread.pass
          end
        end
      end      
    end

    def stop_threads
      @running = false
      @threads.select { |key, thread| thread.alive? }.each do |key, thread|
        RosettaQueue.logger.info "[stop_threads] looping over #{key}, #{thread}"
        if thread[:processing]
          RosettaQueue.logger.info("[stop_threads] Skipping consumer #{key} thread #{thread} because its processing...")
          @running = true
          next
        end
        RosettaQueue.logger.info("[stop_threads] Stopping thread and disconnecting from #{key}...")
        @consumers[key].disconnect
        thread.kill
      end
    end
  end
end
