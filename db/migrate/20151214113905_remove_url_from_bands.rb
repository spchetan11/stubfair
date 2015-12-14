class RemoveUrlFromBands < ActiveRecord::Migration
  def change
  	remove_column :bands, :image_url
  end
end
