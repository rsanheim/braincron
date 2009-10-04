require 'spec_helper'

describe Reminder do

  it "should require description" do
    Reminder.new.should have(1).error_on(:description)
  end

end
