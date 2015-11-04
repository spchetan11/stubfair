class Ticket < ActiveRecord::Base


	belongs_to :event, :foreign_key => "events_id", dependent: :destroy
	belongs_to :user,  :foreign_key => "user_id", dependent: :destroy
	belongs_to :seller,  :foreign_key => "seller_id", dependent: :destroy



  # scope :visible, lambda { where(:visible => true) }
  # scope :invisible, lambda { where(:visible => false) }
  # scope :sorted, lambda { order("subjects.position ASC") }
  # scope :newest_first, lambda { order("subjects.created_at DESC")}
  # scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])

   validates :comments, :length => {:maximum => 1000}
   validates :number_of_tickets, :length => {:maximum => 100}  , :numericality => {:greater_than => 0, :only_integer => true }
   validates :ticket_selling_price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
   validates :ticket_printed_price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than => 0}
   validates :ticket_number, :length =>  {:within => 1..10}
   validates :ticket_type, :inclusion => %w(electronic)

   serialize :notification_params, Hash
  def paypal_url(return_path)
    values = {
        business: "chetan-seller@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: id,
      
        amount: ticket_selling_price,
        item_name: 'ticket',
        item_number: self.id,
        quantity: number_of_tickets,  

        # ticket_number: ticket_number,
        # ticket_type: ticket_type,
        # ticket_selling_price: ticket_selling_price,
        # number_of_tickets: number_of_tickets,
        notify_url: "#{Rails.application.secrets.app_host}/hook"
        
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end


  end
