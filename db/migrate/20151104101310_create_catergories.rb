class CreateCatergories < ActiveRecord::Migration
  def change
    create_table :catergories do |t|
      t.string :category_name

      t.timestamps null: false
    end
  end
end
