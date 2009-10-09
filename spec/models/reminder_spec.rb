require 'spec_helper'

describe Reminder do

  it "should require description" do
    Reminder.new.should have(1).error_on(:description)
  end
  
  describe "setting remind_at" do
    it "should set times normally" do
      reminder = Reminder.new
      time = Time.parse("Jan 1st, 2020 4:00 am")
      reminder.remind_at = time
      reminder.remind_at.should == time
    end

    it "should accept natural text times" do
      reminder = Reminder.new
      time = Chronic.parse("tomorrow at 4 pm")
      reminder.remind_at = "tomorrow at 4pm"
      reminder.remind_at.should == time
    end
  end
  
  describe "need_processing" do
    it "should return reminders scheduled in past that haven't been submitted/processed, oldest first" do
      not_expected = []
      not_expected << Factory(:reminder, :remind_at => 2.minutes.from_now)
      not_expected << Factory(:reminder, :remind_at => 1.day.ago, :submitted_at => 1.minute.ago)
      not_expected << Factory(:reminder, :remind_at => 1.day.ago, :submitted_at => 10.minutes.ago, :processed_at => 5.minutes.ago)
      
      expected = []
      expected << Factory(:reminder, :remind_at => 3.days.ago)
      expected << Factory(:reminder, :remind_at => 20.minutes.ago)
      expected << Factory(:reminder, :remind_at => 1.minutes.ago)
      Reminder.need_processing.should == expected
    end
  end
  
  describe "deliver" do
    it "should create options hash for reminder" do
      user = Factory(:email_confirmed_user, :email => "rob@example.com")
      reminder = Factory(:reminder, :description => "water the plants", :remind_at => 3.days.ago, :user => user)
      options = {
        :config => { :to => "rob@example.com", :from => DO_NOT_REPLY },
        :message => { :summary => "water the plants" }
      }
      reminder.to_hash.should == options
    end
    
    it "should send message to chatterbox" do
      user = Factory(:email_confirmed_user, :email => "rob@example.com")
      reminder = Factory(:reminder, :description => "water the plants", :remind_at => 3.days.ago, :user => user)
      options = {
        :config => { :to => "rob@example.com", :from => DO_NOT_REPLY },
        :message => { :summary => "water the plants" }
      }
      Chatterbox::Email.expects(:deliver).with(options)
      reminder.deliver
    end
  end
  
  describe "to_hash" do
    it "should include the reminder id" do
      fail "do me!"
    end
  end
end
