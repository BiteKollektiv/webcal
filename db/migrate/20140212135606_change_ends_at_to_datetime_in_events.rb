class ChangeEndsAtToDatetimeInEvents < ActiveRecord::Migration
  def self.up
   change_column :events, :ends_at, :datetime
  end

  def self.down
   change_column :events, :ends_at, :timestamp
  end
end
