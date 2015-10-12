class AddTicketNumberToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :ticket_number, :string
  end
end
