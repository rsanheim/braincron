class Reminder < ActiveRecord::Base
  belongs_to :reminder
  
  validates_presence_of :description, :remind_at
  named_scope :upcoming, :conditions => ["remind_at >= ?", Time.zone.now], :order => "remind_at asc"
  
  def remind_at=(time_or_string)
    return super if Time === time_or_string
    parsed_time = Chronic.parse(time_or_string)
    super(parsed_time)
  end
end