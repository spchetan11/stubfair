class AddImageUrlToPopularEvents < ActiveRecord::Migration
  def change
  	add_column :bands, :image_url, :text
  end
end
