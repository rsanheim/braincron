class ReminderUsers < ActiveRecord::Migration
  def self.up
    add_column :reminders, :user_id, :integer, :null => false
  end

  def self.down
    remove_column :reminders, :user_id
  end
end
