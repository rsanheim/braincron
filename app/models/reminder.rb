class Reminder < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :description, :remind_at

  named_scope :upcoming, :conditions => ["remind_at >= ?", Time.zone.now], :order => "remind_at asc"
  named_scope :past_or_now, :conditions => ["remind_at <= ?", Time.zone.now], :order => "remind_at asc"

  def self.need_processing
    past_or_now.all(:conditions => ["submitted_at is null and processed_at is null"])
  end
  
  def remind_at=(time_or_string)
    return super if Time === time_or_string
    parsed_time = Chronic.parse(time_or_string)
    super(parsed_time)
  end
  
  def to_hash
    options = {
      :config => { :to => user.email, :from => DO_NOT_REPLY },
      :message => { :summary => description }
    }
  end
  
  def deliver
    Chatterbox.handle_notice(to_hash)
  end
  
end