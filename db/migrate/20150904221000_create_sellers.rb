class CreateSellers < ActiveRecord::Migration
  def change
    create_table :sellers do |t|
      t.integer :user_id
      t.string :tag_name
      t.string :card_no
      t.string :phone

      t.timestamps null: false
    end
  end
end
