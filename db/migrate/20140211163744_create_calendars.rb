class CreateCalendars < ActiveRecord::Migration
  def change
    create_table :calendars do |t|
      t.string :title
      t.string :description
      t.string :token_read
      t.string :token_write

      t.timestamps
    end
  end
end
