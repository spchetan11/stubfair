class AddUrlToEventImages < ActiveRecord::Migration
  def change
  	add_column :event_images, :image_url, :text
  end
end
