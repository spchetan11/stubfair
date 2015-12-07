ActiveAdmin.register Ticket do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :user_id, :event_id, :published, :comments,  :number_of_tickets, :ticket_type, :ticket_printed_price, :ticket_selling_price, :ticket_number
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end



show do
    attributes_table do
      row :comments
      row :number_of_tickets
      row :ticket_selling_price
      row :ticket_printed_price
      row :published
      row :ticket_type
      row :user_id  do
      	ticket.user_id
      	end
      row :event_id
      row :number_of_images do
      	ticket.ticket_images.length
      end
    #   row :images do
	   #     event.pictures.each{ |img|
	   #     	image_tag img.image.url
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
 