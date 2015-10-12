class RemoveColumnsFromTickets < ActiveRecord::Migration
  def change
  	remove_column :tickets, :seat_number
  	remove_column :tickets, :ticket_type
  	
  	remove_column :tickets, :electronic_tickets
  	remove_column :tickets, :paper_tickets
  	remove_column :tickets, :number_of_e_tickets
  	remove_column :tickets, :number_of_paper_tickets
  	remove_column :tickets, :electronic_tickets_price
  	remove_column :tickets, :paper_tickets_price
  	remove_column :tickets, :electronic_tickets_selling_price
  	remove_column :tickets, :paper_tickets_selling_price

  	add_column :tickets, :ticket_type, :boolean
  	

  end
end
