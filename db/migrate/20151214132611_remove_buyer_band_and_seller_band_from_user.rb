class RemoveBuyerBandAndSellerBandFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :buyer_band
  	remove_column :users, :seller_band
  	add_column :users, :buyer_band, :integer, :default => "1"
  	add_column :users, :seller_band, :integer, :default => "1"
  end
end
