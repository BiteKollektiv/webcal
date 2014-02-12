class ChangeDescriptionToTextInCalendars < ActiveRecord::Migration
  def self.up
   change_column :calendars, :description, :text
  end

  def self.down
   change_column :calendars, :description, :string
  end
end
