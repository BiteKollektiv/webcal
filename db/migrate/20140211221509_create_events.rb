class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :location
      t.text :description
      t.timestamp :starts_at
      t.timestamp :ends_at
      t.references :calendar, index: true

      t.timestamps
    end
  end
end
