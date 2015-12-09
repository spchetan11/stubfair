class ChangePurchaseFlagToPurchaseTransactions < ActiveRecord::Migration
  def change
  	rename_column :transactions, :purchase_flag, :purchased
  end
end
