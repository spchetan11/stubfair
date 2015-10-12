class CreateTrustedUsers < ActiveRecord::Migration
  def change
    create_table :trusted_users do |t|
      t.integer :user_id
      t.string :comments

      t.timestamps null: false
    end
  end
end
