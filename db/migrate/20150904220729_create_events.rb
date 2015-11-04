class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :description
      t.string :venue
      t.string :genere
      t.datetime :event_date_time

      t.timestamps null: false
    end
  end
end
