class AddBookingIdToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :booking_id, :string
  end
end
