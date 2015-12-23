class Transaction < ActiveRecord::Base
	belongs_to :user, :foreign_key => "user_id"
	belongs_to :ticket, :foreign_key => "ticket_id"
	belongs_to :event, :foreign_key => "event_id"

	#validates :transaction_id, :presence =>true, :uniqueness =>  true

	def tickets_purchased_mail
    UserMailer.tickets_purchased(self).deliver_now
    end
end
