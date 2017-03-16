class AddMoreTicketDetails < ActiveRecord::Migration
  def change
  	add_column :tickets, :section, :string
  	add_column :tickets, :row, :string
  	add_column :tickets, :seat_number, :string
  	add_column :events, :stadium_image_url, :text
  end
end
