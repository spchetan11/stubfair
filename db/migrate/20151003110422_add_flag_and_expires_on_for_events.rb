class AddFlagAndExpiresOnForEvents < ActiveRecord::Migration
  def change
  	add_column :events, :published, :boolean, :default => false
  	add_column :events, :expires_on, :datetime
  end
end
