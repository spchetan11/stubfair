class AddForeignKeyUserIdForSellers < ActiveRecord::Migration
  def change
  	remove_column :sellers, :user_id
  	add_reference :sellers, :user, index: true, foreign_key: true

  end
end
