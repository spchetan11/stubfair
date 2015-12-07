ActiveAdmin.register Event do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :category,:title, :description, :venue, :genre, :event_date_time,:user_id, :expires_on,:published, :location
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

show do
    attributes_table do
      row :title
      row :description
      row :category
      row :venue
      row :location
      row :event_date_time
      row :expires_on
      row :published
      row :event_id  do 

        event.id
        
      end
        
      row :user_id do 
        event.user_id
      end
      row :number_of_images do
      	event.pictures.length
      end
    #   row :images do
	   #     event.pictures.each{ |img|
	   #     	image_tag img.image.url
	   #     }
	   # end
	  table_for event.pictures do
	  	#column :description do |col|
	  		#{}"#{col.description}"
	  	#end
        column :image do |col|
        	image_tag col.image.url, class: "img-responsive" ,style: "width: 600px;"
        end
      end
    
    table_for event.tickets do 
      column :tickets do |ticket| 
        
        ticket.number_of_tickets
     
      end
    end

    end
    # active_admin_comments
  end


end
