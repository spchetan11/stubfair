# Load the Rails application.
require File.expand_path('../application', __FILE__)
#require 'tlsmail' 
# Initialize the Rails application.
Rails.application.initialize!


#devise mail setup

     
#Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)

# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.perform_deliveries = true
# ActionMailer::Base.raise_delivery_errors = true
# ActionMailer::Base.smtp_settings = {
#   :ssl_version => 'SSLv3',	
#   :enable_starttls_auto => true,  
#   :address            => 'smtp.gmail.com',
#   :port               => 587,
#   :tls                  => true,
#   :domain             => 'gmail.com', #you can also use google.com
#   :authentication     => :plain,
#   :user_name          => 'stubfairsmtp@gmail.com',
#   :password           => 'stubfair1',
#   :openssl_verify_mode  => 'none'
# }