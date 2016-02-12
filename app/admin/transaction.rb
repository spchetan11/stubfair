ActiveAdmin.register Transaction do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_id, :ticket_id, :expires_on, :purchase_amount, :comments, :number_of_tickets, :ticket_printed_price, :ticket_number, :published, :event_id, :ticket_selling_price, :sale_amount, :ticket_type, :ticket_created_at, :ticket_updated_at, :purchased, :number_of_tickets_purchased, :notification_params, :status, :transaction_id,:purchased_at, :seller_id, :booking_id,:row,:seat_number,:section
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

index do 
  id_column
    column "Transaction ID", :transaction_id
    column :status
    column :number_of_tickets
    column :ticket_printed_price
    column :ticket_selling_price
    column :purchase_amount
    column "Booking ID", :booking_id
    column :ticket_type
    column :number_of_tickets_purchased
    column :published
    column :purchased_at
        #  column :user_id  do
        # transaction.user_id
        # end

        #  column :ticket_id  do
        # transaction.ticket_id
        # end

        #  column :event_id  do
        # transaction.event_id
        # end
    actions


  
end


end
