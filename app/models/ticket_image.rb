class TicketImage < ActiveRecord::Base
	belongs_to :ticket, class_name: "Ticket"
    has_attached_file :image
    #validates_attachment_content_type :image, :content_type => ['application/pdf']
    
    do_not_validate_attachment_file_type :image
    # :path => ":rails_root/public/images/:id/:filename",
    # :url  => "/images/:id/:filename"


  

    # belongs_to :ticket, class_name: "Ticket"
    # has_attached_file :image
    # do_not_validate_attachment_file_type :image
    # :path => ":rails_root/public/images/:id/:filename",
    # :url  => "/images/:id/:filename"

   
end

