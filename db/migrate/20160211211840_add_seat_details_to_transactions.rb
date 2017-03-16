class AddSeatDetailsToTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :section, :string
  	add_column :transactions, :row, :string
  	add_column :transactions, :seat_number, :string
  end
end
