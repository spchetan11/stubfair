class RenamePurchasesToTransactions < ActiveRecord::Migration
  def change
  	rename_table :purchases, :transactions
    add_column :transactions, :purshase, :boolean
    add_column :transactions, :sale, :boolean
  end
end
