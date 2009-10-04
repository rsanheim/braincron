require 'spec_helper'

describe RemindersController do
  describe "create" do
    it "should create reminder with valid params" do
      sign_in
      post :create, :reminder => {:description => "walk the dog", :remind_at => 2.days.from_now.to_s}
      assigns(:reminder).description.should == "walk the dog"
    end
    
    it "should redirect to index on success" do
      sign_in
      post :create, :reminder => {:description => "foo"}
      response.should redirect_to(reminders_url)
    end
    
    it "should render new if there are errors" do
      sign_in
      post :create, :reminder => {:description => ""}
      response.should render_template('reminders/new')
    end
  end
  
  describe "index" do
    it "should set new reminder to prep for create" do
      user = sign_in
      user.stubs(:reminders).returns(stub_everything(:new => "new reminder"))
      get :index
      assigns(:reminder).should == "new reminder"
    end
    
    it "should display current reminders" do
      user = sign_in
      user.stubs(:reminders).returns(stub_everything(:upcoming => ["users reminders"]))
      get :index
      assigns(:reminders).should == ["users reminders"]
    end
  end
end