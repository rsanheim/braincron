class RemindersController < ApplicationController
  
  def new
    @reminder = Reminder.new
  end
  
  def create
    @reminder = Reminder.new(params[:reminder])
    if @reminder.save
      redirect_to reminders_path
    else
      render :action => :new
    end
  end
  
  def index
    
  end
end
