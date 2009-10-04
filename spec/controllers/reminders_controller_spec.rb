require 'spec_helper'

describe RemindersController do
  describe "new" do
    
  end
  
  describe "create" do
    it "should create reminder with valid params" do
      post :create, :reminder => {:description => "walk the dog", :remind_at => 2.days.from_now.to_s}
      assigns(:reminder).description.should == "walk the dog"
    end
    
    it "should redirect to index on success" do
      post :create, :reminder => {:description => "foo"}
      response.should redirect_to(reminders_url)
    end
    
    it "should render new if there are errors" do
      post :create, :reminder => {:description => ""}
      response.should render_template('reminders/new')
    end
  end
  
  describe "index" do
    it "should set new reminder to prep for create" do
      reminder = Factory.build(:reminder)
      Reminder.expects(:new).returns(reminder)
      get :index
      assigns(:reminder).should == reminder
    end
  end
end