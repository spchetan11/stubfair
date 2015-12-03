class AddImageUrlToTicketImages < ActiveRecord::Migration
  def change
  	add_column :ticket_images, :image_url, :text
  end
end
