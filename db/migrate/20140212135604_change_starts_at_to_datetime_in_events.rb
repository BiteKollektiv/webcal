class ChangeStartsAtToDatetimeInEvents < ActiveRecord::Migration
  def self.up
   change_column :events, :starts_at, :datetime
  end

  def self.down
   change_column :events, :starts_at, :timestamp
  end
end
