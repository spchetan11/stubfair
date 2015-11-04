class AddPrintedPriceToTickets < ActiveRecord::Migration
  def change

  	 remove_column :tickets, :ticket_restrictions
  	 add_column :tickets, :ticket_printed_price, :float
  	 rename_column :tickets, :ticket_price, :ticket_selling_price
  	 remove_column :tickets, :ticket_type
  	 add_column :tickets, :ticket_type, :string
  end
end
