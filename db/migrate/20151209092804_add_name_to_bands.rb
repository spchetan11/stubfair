class AddNameToBands < ActiveRecord::Migration
  def change
  	add_column :bands, :name, :string
  	add_column :bands, :value, :float
  end
end
