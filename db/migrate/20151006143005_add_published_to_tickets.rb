class AddPublishedToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :published, :boolean, :default => false
  end
end
