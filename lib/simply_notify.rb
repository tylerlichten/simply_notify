require "simply_notify/version"
require "action_mailer"

class Notifier < ActionMailer::Base
  default :from => 'no-reply@brandeis.edu'

  def new_notification(recipient)
    @recipient = recipient
    mail(:to => recipient.email, 
      	 :subject => 'New Notification',
         :content_type => 'text/html')
  end
end