class Event < ActiveRecord::Base
	has_many :tickets, :dependent => :destroy
    has_many :pictures, :dependent => :destroy
    has_many :event_images, :dependent => :destroy
	belongs_to :user, :foreign_key => "user_id"

	has_attached_file :stadium_image
    validates_attachment_content_type :stadium_image, :content_type => /\Aimage\/.*\Z/
    validates_attachment :stadium_image#, presence: true
    # do_not_validate_attachment_file_type :stadium_image

    #validates_attachment_content_type :ticket_attachment, :content_type => [/png\Z/, /jpe?g\Z/, /gif\Z/]
    #DONT FORGET TO SETUP paperclip.rb IN CONFIG->INITIALIZERS
    #AND PASTE  --  Paperclip::Railtie.insert -- IN CONFIG->LOCALES->application.rb
    #add config.gem 'paperclip' to your environment.rb 
    #scope :named, lambda {|title,venue| where(:title => title, :venue => venue)}
    # scope :visible, lambda { where(:visible => true) }
    # scope :invisible, lambda { where(:visible => false) }
    # scope :sorted, lambda { order("subjects.position ASC") }
    # scope :newest_first, lambda { order("subjects.created_at DESC")}
    # scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])
    
    scope :upcoming, -> {
    date = Date.today >> 1
    where(event_date_time: (date.beginning_of_month..date.end_of_month))
    }
    validates :title, :length => {:maximum => 30}, :presence =>true
    validates :description, :length => {:maximum => 10000}, :presence =>true
    validates :venue, :length => {:maximum => 30}, :presence =>true
    validates :location, :length => {:maximum => 50}, :presence =>true
    #validates :genre, :length => {:maximum => 30}, :presence =>true
    validates :category, :inclusion => %w(Concerts Sports Theatre Comedy Festivals Family Deals Other)


# def to_s
#     self.user_id
# end    

after_validation :is_published_changed
 
  protected
    def is_published_changed
      if published_changed?
        if published?
           self.events_published_mail
        end
      end
    end

    def events_published_mail
    UserMailer.events_published(self).deliver_now
    end
end




