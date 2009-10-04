class RemindersController < ApplicationController
  before_filter :authenticate
  
  def create
    @reminder = current_user.reminders.new(params[:reminder])
    if @reminder.save
      redirect_to reminders_path
    else
      render :action => :new
    end
  end
  
  def index
    @reminder = current_user.reminders.new
    @reminders = current_user.reminders.upcoming
  end
end
