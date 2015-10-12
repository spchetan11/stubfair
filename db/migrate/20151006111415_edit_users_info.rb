class EditUsersInfo < ActiveRecord::Migration
  def change
  	rename_column :users, :name, :first_name
  	add_column :users, :last_name, :string
  	add_column :users, :address, :text
  	add_column :users, :postcode, :integer
  	remove_column :sellers, :phone
  end
end
