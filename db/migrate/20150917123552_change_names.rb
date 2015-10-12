class ChangeNames < ActiveRecord::Migration
  def change
    rename_column :users,:password_digest, :encrypted_password
    add_column :users, :password_digest, :string
  end
end
