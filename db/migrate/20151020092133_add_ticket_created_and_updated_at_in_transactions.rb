class AddTicketCreatedAndUpdatedAtInTransactions < ActiveRecord::Migration
  def change
  	add_column :transactions, :ticket_created_at, :datetime
  	add_column :transactions, :ticket_updated_at, :datetime
  end
end
