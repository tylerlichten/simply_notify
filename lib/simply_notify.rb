require "simply_notify/version"
require "action_mailer"

class Notifier < ActionMailer::Base
  default from: 'brandeisapprenticeship@gmail.com'

  def new_notification(recipient)
    mail(to: recipient, 
      	 subject: 'New Notification')
  end
end