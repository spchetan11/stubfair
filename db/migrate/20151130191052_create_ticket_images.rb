class CreateTicketImages < ActiveRecord::Migration
  def change
    create_table :ticket_images do |t|

      t.timestamps null: false
    end
  end
end
