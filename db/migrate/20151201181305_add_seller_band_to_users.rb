class AddSellerBandToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :buyer_band, :float
  end
end
