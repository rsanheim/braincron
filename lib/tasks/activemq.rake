namespace :activemq do
  desc "Start ActiveMQ"
  task :start do
    system("$ACTIVEMQ_HOME/bin/activemq xbean:file:./config/activemq.xml > /dev/null &") || abort("Starting ActiveMQ failed")
  end

  desc "Stop ActiveMQ"
  task :stop do
    pid = `ps -ax |grep [a]ctivemq.xml|awk '{print $1}'`
    puts "Stopping ActiveMQ at PID #{pid}"
    system("kill #{pid}") || abort("Stoppin ActiveMQ failed")
  end
end