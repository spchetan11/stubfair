class EditTransactions < ActiveRecord::Migration
  def change
  	remove_column :transactions, :purchase
  	remove_column :transactions, :sale
  	add_column :transactions, :purchase_flag, :boolean 
  	add_column :transactions, :number_of_tickets_purchased, :integer

  end
end
