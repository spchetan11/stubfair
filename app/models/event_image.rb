class EventImage < ActiveRecord::Base
	belongs_to :event, class_name: "Event"
    has_attached_file :attachment
    do_not_validate_attachment_file_type :attachment,
    	:styles => {
		:thumb => "100x100#",
		:small  => "150x150>",
		:medium => "200x200"
	}

    #development
    # belongs_to :event, class_name: "Event"
   
    # has_attached_file :attachment,
    # :path => ":rails_root/public/images/:id/:filename",
    # :url  => "/images/:id/:filename"
    # do_not_validate_attachment_file_type :attachment
end
