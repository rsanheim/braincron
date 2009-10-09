require 'spec_helper'

describe Producer do
  
  it "memoizes the logger" do
    logger = stub_everything("logger")
    Logger.expects(:new).once.with(anything).returns(logger)
    Producer.logger.should == logger
    Producer.logger.should == logger
  end
  
  it "should submit any reminders needing processing" do
    expected = []
    expected << Factory(:reminder, :remind_at => 1.minute.ago)
    expected << Factory(:reminder, :remind_at => 5.minutes.ago)
    Factory(:reminder, :remind_at => 2.minutes.from_now)
    Producer.expects(:publish).with(expected.first)
    Producer.expects(:publish).with(expected.second)
    Producer.run
  end
  
  it "should publish message to requests queue" do
    RosettaQueue::Producer.expects(:publish).with(:requests, {:test => "message"})
    Producer.publish({:test => "message"})
  end
  
end