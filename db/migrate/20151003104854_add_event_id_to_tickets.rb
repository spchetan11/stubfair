class AddEventIdToTickets < ActiveRecord::Migration
  def change
  	#remove_column :tickets, :event_id
  	add_reference :tickets, :user, index: true, foreign_key: true
  	add_reference :tickets, :events, index: true, foreign_key: true
end
end
