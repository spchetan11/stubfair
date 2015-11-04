class EditTransactionsTableAgain < ActiveRecord::Migration
  def change
  	remove_column :transactions, :status
  	add_column :transactions, :status, :string, :default => "Processing"
  end
end
