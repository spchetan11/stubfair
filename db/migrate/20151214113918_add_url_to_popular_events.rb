class AddUrlToPopularEvents < ActiveRecord::Migration
  def change
  	add_column :popular_events, :image_url, :text
  end
end
