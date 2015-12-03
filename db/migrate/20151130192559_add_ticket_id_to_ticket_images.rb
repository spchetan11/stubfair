class AddTicketIdToTicketImages < ActiveRecord::Migration
  def change
  	add_reference :ticket_images, :ticket, references: :tickets, index: true
    add_foreign_key :ticket_images, :tickets, column: :ticket_id
  end
end
