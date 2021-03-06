class CreateReminders < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.string :description, :null => false
      t.datetime :remind_at
      t.timestamps
    end
  end

  def self.down
    drop_table :reminders
  end
end
