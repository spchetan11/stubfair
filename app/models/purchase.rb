class Purchase < ActiveRecord::Base
	belongs_to :user, :foreign_key => "user_id", dependent: :destroy
	belongs_to :ticket, :foreign_key => "ticket_id", dependent: :destroy
end
