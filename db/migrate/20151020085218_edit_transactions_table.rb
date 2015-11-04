class EditTransactionsTable < ActiveRecord::Migration
  def change
  	rename_column :transactions, :ticket_price, :ticket_printed_price
  	add_column :transactions, :ticket_selling_price, :float
  	remove_column :transactions, :ticket_restrictions
  	rename_column :transactions, :purshase, :purchase
  	add_column :transactions, :sale_amount, :float
  	remove_column :transactions, :ticket_type
  	add_column :transactions, :ticket_type, :string 
  end
end
