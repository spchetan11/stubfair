ActiveAdmin.register Transaction do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :user_id, :ticket_id, :expires_on, :purchase_amount, :comments, :number_of_tickets, :ticket_printed_price, :ticket_number, :published, :event_id, :ticket_selling_price, :sale_amount, :ticket_type, :ticket_created_at, :ticket_updated_at, :purchased, :number_of_tickets_purchased, :notification_params, :status, :transaction_id,:purchased_at, :seller_id
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end


end
