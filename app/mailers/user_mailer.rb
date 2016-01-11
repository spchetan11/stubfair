class UserMailer < ActionMailer::Base

  
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def events_published(event)
    @user_email = event.user.email
    mail from: "stubfair@gmail.com", to: event.user.email, subject: "Your events are now published on stubfair.com"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def tickets_published(ticket)
    @user_email = ticket.user.email
    mail from: "stubfair@gmail.com", to: ticket.user.email, subject: "Your tickets are now published on stubfair.com"
  end

  def tickets_purchased(current_user)
    @user_email = current_user.email
    mail from: "stubfair@gmail.com", to: current_user.email, subject: "Stubfair.com - Purchase Complete"
  end

  def tickets_sold(seller)
    @user_email = seller.email
    mail from: "stubfair@gmail.com", to: seller.email, subject: "Stubfair.com - Your listed ticket have been sold"
  end

end
