ActiveAdmin.register Ticket do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :user_id, :event_id, :published,  :number_of_tickets, :ticket_type, :ticket_printed_price, :ticket_selling_price, :ticket_number, :ticket_type, :section, :seat_number, :row, :booking_id, :number_of_tickets_purchased
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

index do 
  id_column
    column "Booking ID", :booking_id
    column :number_of_tickets
    # column :comments do |data|
    #   data.description[0..30]
    # end
    column :ticket_selling_price
    column "Ticket Face Value", :ticket_printed_price
    column :ticket_type
    column :section
    column :row
    column :seat_number
    column :published
    column :number_of_tickets_purchased
    actions
end

show do
    attributes_table do
      row :booking_id
      row :number_of_tickets
      row :number_of_tickets_purchased
      row :ticket_selling_price
      row :ticket_printed_price
      row :published
      row :ticket_type
      row :section
      row :row
      row :seat_number
   
      row :user_id  do
        ticket.user_id
        end
      row :event_id
      row :number_of_images do
        ticket.ticket_images.length
      end
    #   row :images do
     #     event.pictures.each{ |img|
     #      image_tag img.image.url
     #     }
     # end
    table_for ticket.ticket_images do
      #column :description do |col|
        #{}"#{col.description}"
      #end
        column :image do |col|
          image_tag col.image.url, class: "img-responsive" ,style: "width: 600px;"
        end
      end
    end
    # active_admin_comments
  end

end
