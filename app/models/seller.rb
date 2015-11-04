class Seller < ActiveRecord::Base
	belongs_to :user, :foreign_key => "user_id", dependent: :destroy

end
