class Event < ActiveRecord::Base
    

   
	has_many :tickets 
	belongs_to :user, :foreign_key => "user_id", dependent: :destroy


	has_attached_file :ticket_attachment
    #validates_attachment_content_type :ticket_attachment, :content_type => [/png\Z/, /jpe?g\Z/, /gif\Z/]
    do_not_validate_attachment_file_type :ticket_attachment
    #DONT FORGET TO SETUP paperclip.rb IN CONFIG->INITIALIZERS
    #AND PASTE  --  Paperclip::Railtie.insert -- IN CONFIG->LOCALES->application.rb
    #add config.gem 'paperclip' to your environment.rb 

	scope :named, lambda {|title,venue| where(:title => title, :venue => venue)}
end
