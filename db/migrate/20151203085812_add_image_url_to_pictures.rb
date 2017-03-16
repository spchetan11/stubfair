class AddImageUrlToPictures < ActiveRecord::Migration
  def change
  	add_column :pictures, :image_url, :text
  end
end
