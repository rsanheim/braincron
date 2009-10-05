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
end
