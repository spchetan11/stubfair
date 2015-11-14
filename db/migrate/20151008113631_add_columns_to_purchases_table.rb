class AddColumnsToPurchasesTable < ActiveRecord::Migration
  def change
  	add_column :purchases, :expires_on, :datetime
  	add_column :purchases, :purchase_amount,  :float
    add_column :purchases, :comments, :string
    #add_column :purchases, :seller_id, :integer
    add_column :purchases, :number_of_tickets, :integer
    add_column :purchases, :ticket_price, :float
    add_column :purchases, :ticket_restrictions, :text
    add_column :purchases, :ticket_number, :string
    add_column :purchases, :published, :boolean
    add_column :purchases, :ticket_type, :boolean
    add_column :purchases, :status, :integer

  	add_reference :purchases, :event, index: true, foreign_key: true
  	
  end
end
