class MakePurchasedTicketsZeroDefault < ActiveRecord::Migration
  def change
  	change_column :tickets, :number_of_tickets_purchased, :integer, :default => 0
  end
end
