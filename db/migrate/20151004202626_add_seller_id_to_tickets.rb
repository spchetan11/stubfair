class AddSellerIdToTickets < ActiveRecord::Migration
  def change
  	#remove_column :tickets, :seller_id
  	#add_reference :tickets, :seller, index: true, foreign_key: true
  end
end
