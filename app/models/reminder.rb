class Reminder < ActiveRecord::Base
  belongs_to :reminder
  
  validates_presence_of :description
  named_scope :upcoming, :conditions => ["remind_at >= ?", Time.zone.now], :order => "remind_at asc"
end