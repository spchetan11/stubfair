class Ticket < ActiveRecord::Base


	belongs_to :event, :foreign_key => "events_id", dependent: :destroy
	belongs_to :user,  :foreign_key => "user_id", dependent: :destroy
	belongs_to :seller,  :foreign_key => "seller_id", dependent: :destroy



  # scope :visible, lambda { where(:visible => true) }
  # scope :invisible, lambda { where(:visible => false) }
  # scope :sorted, lambda { order("subjects.position ASC") }
  # scope :newest_first, lambda { order("subjects.created_at DESC")}
  # scope :search, lambda {|query| where(["name LIKE ?", "%#{query}%"])


  end
