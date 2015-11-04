class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :transactions 
  has_many :events 
  has_many :tickets , dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #has_secure_password

  EMAIL_REGEX = /\b[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-]+\.)+[A-Za-z]{2,4}\z/

  validates :first_name, :length => {:maximum => 30}, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  validates :last_name, :length => {:maximum => 30}, format: { with: /\A[a-zA-Z]+\z/,
    message: "only allows letters" }
  validates :email, :presence =>true, :length => {:maximum => 100}, :format => EMAIL_REGEX, :confirmation => true, :uniqueness => { :case_sensitive => false }
  #validates :password, :confirmation => true, :length => {:within => 8..20}, :presence =>true
  validates :gender, :inclusion => %w(male female)
  validates :address,  :length =>  {:maximum => 100}
  validates :postcode, :length =>  {:within => 3..10}, numericality: { only_integer: true }

  
  def name
    "#{first_name} #{last_name}"
    # Or: first_name + ' ' + last_name
    # Or: [first_name, last_name].join(' ')
  end

end
