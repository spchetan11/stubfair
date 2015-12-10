class Picture < ActiveRecord::Base

 
	belongs_to :event, class_name: "Event"
    has_attached_file :image
    do_not_validate_attachment_file_type :image
    # :path => ":rails_root/public/images/:id/:filename",
    # :url  => "/images/:id/:filename"
    
    
end
