ActiveAdmin.register Event do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :category,:title, :description, :venue, :event_date_time,:user_id, :expires_on,:published, :location, :stadium_image
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

form :html => { :enctype => "multipart/form-data"} do |f|
  f.inputs "New Event" do 
    f.input :user_id, as: :select, collection: User.all.select(:id)
    f.input :title
    f.input :description
    f.input :category, as: :select, collection: ['Concerts', 'Sports', 'Theatre', 'Comedy', 'Festivals', 'Family', 'Deals', 'Other']
    f.input :venue
    f.input :location
    f.input :event_date_time
    f.input :published
    f.input :stadium_image, :required => true, :as => :file       
  end   
  
  # for custom actions
  f.actions do 
    f.action :submit, :as => :button ,:label => 'Create Item'
    f.action :cancel, :as => :link, :label => 'Cancel',:wrapper_html => { :class=>"cancel" }
  end 
end

index do 
  id_column
  
    column :title
    column :description do |data|
      data.description[0..30]
    end
    column :category
    column :venue
    column :location
    column :event_date_time
    column :stadium_image_file_name
    #column :stadium_image_url
    column :published
    actions


  
end

# form do |f|
#     f.input :user_id do 
#         event.user_id
#       end
#     f.input :category
#     f.input :title
#     f.input :description
#     f.input :venue
#     f.input :location
#     f.input :event_date_time
#     f.input :published
#     f.actions

# end

show do
    attributes_table do
      row :title
      row :description
      row :category
      row :venue
      row :location
      row :event_date_time
      # row :expires_on
      row :published
      row :event_id  do 

        event.id
        
      end
      row :stadium_image do |col|
          image_tag col.stadium_image.url, class: "img-responsive" ,style: "width: 600px;"
        end
        
      row :user_id do 
        event.user_id
      end
      row :number_of_images do
        event.event_images.length
      end
    #   row :attachments do
     #     event.event_images.each{ |img|
     #      image_tag img.attachment.url
     #     }
     # end
    table_for event.event_images do
      #column :description do |col|
        #{}"#{col.description}"
      #end
        column :attachment do |col|
          image_tag col.attachment.url, class: "img-responsive" ,style: "width: 600px;"
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
