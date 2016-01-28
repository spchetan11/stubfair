class Ticket < ActiveRecord::Base

  #change event_id to events_id after heroku push
	#belongs_to :event, :foreign_key => "event_id", dependent: :destroy
	belongs_to :user,  :foreign_key => "user_id"
  belongs_to :event, class_name: "Event"
  has_many :transactions
  has_many :ticket_images, :dependent => :destroy
	
  
  
  

  # scope :visible, lambda { where(:visible => true) }
  # scope :invisible, lambda { where(:visible => false) }
  # scope :sorted, lambda { order("subjects.position ASC") }
  # scope :newest_first, lambda { order("subjects.created_at DESC")}
  # scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])

   #validates :comments, :length => {:maximum => 1000}
   validates :number_of_tickets, :length => {:maximum => 100}  , :numericality => {:greater_than => 0, :only_integer => true }
   validates :ticket_selling_price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than_or_equal_to => 0.0}
   validates :ticket_printed_price, :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }, :numericality => {:greater_than_or_equal_to => 0.0}
   #validates :ticket_number, :length =>  {:within => 1..50}
   validates :ticket_type, :inclusion => %w(Electronic Paper)
   validates :booking_id, :length =>  {:within => 1..50}

   serialize :notification_params, Hash


  
   def paypal_url(return_path,no_of_ticket,event_name,tx_id)
    values = {
        business: "chetan-seller@gmail.com",
        cmd: "_xclick",
        upload: 1,
        return: "#{Rails.application.secrets.app_host}#{return_path}",
        invoice: tx_id,
        #invoice: '886',
      
        amount: (ticket_selling_price * no_of_ticket.to_f) + (0.05 *(ticket_selling_price * no_of_ticket.to_f) ),
        item_name: event_name,
        item_number: self.id,
        #quantity: no_of_ticket,  
        notify_url: "#{Rails.application.secrets.app_host}/hook"
        
    }
    "#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  def quantity_available
      number_of_tickets - transactions.sum(:number_of_tickets_purchased)
  end

# FOR PAYPAL SITE TO SELLER PAYMENT

#   def self.send_money(to_email, how_much_in_cents, options = {})
#   credentials = {
#     "USER" => "chetan-seller_api1.gmail.com",
#     "PWD" => "J7AXDX3QQWVU2UZ2",
#     "SIGNATURE" => "AFcWxV21C7fd0v3bYYYRCpSSRl31ADb9r-ueKABlYKBV2b6tCmWKZuYq"
#   }
 
#   params = {
#     "METHOD" => "MassPay",
#     "CURRENCYCODE" => "USD",
#     "RECEIVERTYPE" => "EmailAddress",
#     "L_EMAIL0" => to_email,
#     "L_AMT0" => ((how_much_in_cents.to_i)/100.to_f).to_s,
#     "VERSION" => "51.0"
#   }
 
#   endpoint = RAILS_ENV == 'production' ? "https://api-3t.paypal.com" : "https://api-3t.sandbox.paypal.com"
#   url = URI.parse(endpoint)
#   http = Net::HTTP.new(url.host, url.port)
#   http.use_ssl = true
#   all_params = credentials.merge(params)
#   stringified_params = all_params.collect { |tuple| "#{tuple.first}=#{CGI.escape(tuple.last)}" }.join("&")
 
#   response = http.post("/nvp", stringified_params)
# end

    after_validation :is_published_changed
 
  protected
    def is_published_changed
      if published_changed?
        if published?
           self.tickets_published_mail
        end
      end
    end

    def tickets_published_mail
    UserMailer.tickets_published(self).deliver_now
    end

end
