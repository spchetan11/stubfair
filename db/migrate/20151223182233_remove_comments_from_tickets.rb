class RemoveCommentsFromTickets < ActiveRecord::Migration
  def change
  	remove_column :tickets, :comments
  end
end
