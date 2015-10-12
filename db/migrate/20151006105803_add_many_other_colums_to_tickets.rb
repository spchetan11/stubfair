class AddManyOtherColumsToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :number_of_tickets, :integer
  	add_column :tickets, :ticket_type, :text
  	add_column :tickets, :ticket_price, :float
  	add_column :tickets, :ticket_restrictions, :text
  	add_column :tickets, :electronic_tickets, :boolean
  	add_column :tickets, :paper_tickets, :boolean
  	add_column :tickets, :number_of_e_tickets, :integer
  	add_column :tickets, :number_of_paper_tickets, :integer
  	add_column :tickets, :electronic_tickets_price, :float
  	add_column :tickets, :paper_tickets_price, :float
  	add_column :tickets, :electronic_tickets_selling_price, :float
  	add_column :tickets, :paper_tickets_selling_price, :float
  end
end
