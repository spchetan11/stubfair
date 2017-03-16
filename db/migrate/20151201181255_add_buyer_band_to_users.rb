class AddBuyerBandToUsers < ActiveRecord::Migration
  def change
  	 	add_column :users, :seller_band, :float
  end
end
