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
end
