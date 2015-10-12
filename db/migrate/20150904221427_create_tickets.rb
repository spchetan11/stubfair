class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :seller_id
      t.integer :event_id
      t.string :seat_number
      t.string :comments

      t.timestamps null: false
    end
  end
end
