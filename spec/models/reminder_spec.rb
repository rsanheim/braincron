require 'spec_helper'

describe Reminder

  it "should require description" do
    Reminder.new.should have(1).error.on(:description)
  end

end
