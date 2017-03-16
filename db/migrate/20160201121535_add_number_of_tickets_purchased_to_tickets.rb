class AddNumberOfTicketsPurchasedToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :number_of_tickets_purchased, :integer
  end
end
