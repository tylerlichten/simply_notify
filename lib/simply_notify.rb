require "simply_notify/version"
require "action_mailer"

class Notifier < ActionMailer::Base

  def new_notification(recipient, url)
  	if url.nil?
      @url = Rails.application.config.absolute_site_url
  	  mail(to: recipient, 
           subject: 'New Notification')
  	else 
  	  @url = url
      mail(to: recipient, 
           subject: 'New Notification')
    end 
  end
end