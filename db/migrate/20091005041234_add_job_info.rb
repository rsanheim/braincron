class AddJobInfo < ActiveRecord::Migration
  def self.up
    add_column :reminders, :submitted_at, :datetime
    add_column :reminders, :processed_at, :datetime
    add_column :reminders, :success, :boolean, :default => false
  end

  def self.down
    remove_column :reminders, :success
    remove_column :reminders, :processed_at
    remove_column :reminders, :submitted_at
  end
end
