class ChangeColumnNameForGenre < ActiveRecord::Migration
  def change
  	rename_column :events, :genere, :genre
  end
end
