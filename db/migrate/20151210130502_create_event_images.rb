class CreateEventImages < ActiveRecord::Migration
  def change
    create_table :event_images do |t|

      t.timestamps null: false
    end
  end
end
