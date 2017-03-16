class AddBookingIdToTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :booking_id, :string
  end
end
