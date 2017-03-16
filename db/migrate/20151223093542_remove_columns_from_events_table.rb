class RemoveColumnsFromEventsTable < ActiveRecord::Migration
  def change
  	remove_column :events, :genre
  	remove_column :events, :expires_on
  end
end
