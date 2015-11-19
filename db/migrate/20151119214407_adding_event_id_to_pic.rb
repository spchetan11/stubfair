class AddingEventIdToPic < ActiveRecord::Migration
  def change
  	add_reference :pictures, :event, references: :events, index: true
    add_foreign_key :pictures, :events, column: :event_id
  end
end
