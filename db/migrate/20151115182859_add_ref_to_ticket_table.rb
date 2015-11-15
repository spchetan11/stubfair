class AddRkefToTicketTable < ActiveRecord::Migration
  def change
  	add_reference :tickets, :event, references: :events, index: true
    add_foreign_key :tickets, :events, column: :event_id
  end
end
