class AddForeignKeysToPurchases < ActiveRecord::Migration
  def change
  	remove_column :purchases, :user_id
  	remove_column :purchases, :ticket_id
  	add_reference :purchases, :user, index: true, foreign_key: true
  	add_reference :purchases, :ticket, index: true, foreign_key: true

  end
end
