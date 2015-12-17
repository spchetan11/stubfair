require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'tlsmail' 
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module StubfairClient
  class Application < Rails::Application
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    Paperclip::Railtie.insert

#Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
#    :tls => true,
#    :address => "smtp.gmail.com",
#    :port => 587,
#    :domain => "gmail.com",
#    :authentication => :login,
#    :user_name => "stubfairsmtp@gmail.com",
#    :password => "stubfair1"
#  }

    
Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,  
  :address            => 'smtp.gmail.com',
  :port               => 587,
  :tls                  => true,
  :domain             => 'gmail.com', #you can also use google.com
  :authentication     => :plain,
  :user_name          => 'stubfairsmtp@gmail.com',
  :password           => 'stubfair1',
  :openssl_verify_mode  => 'none'
}

  end
end
