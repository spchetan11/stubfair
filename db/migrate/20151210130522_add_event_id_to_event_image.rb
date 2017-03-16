class AddEventIdToEventImage < ActiveRecord::Migration
  def change
    add_reference :event_images, :event, references: :events, index: true
    add_foreign_key :event_images, :events, column: :event_id
  end
end
