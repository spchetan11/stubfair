class AddParamsStatusTransactionIdPurchasedAtToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :notification_params, :text
    remove_column :transactions, :status
    add_column :transactions, :status, :string
    add_column :transactions, :transaction_id, :string
    add_column :transactions, :purchased_at, :datetime
  end
end
