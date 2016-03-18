require "simply_notify/version"
require "action_mailer"
require "ahoy_email"

class Notifier < ActionMailer::Base
  track utm_campaign: "boom"

  def new_notification(recipient, url, subject)
    track user: recipient

    if url.nil?
      @url = Rails.application.config.absolute_site_url
      mail(to: recipient.email, 
           subject: subject)
    else 
      @url = url
      mail(to: recipient.email, 
           subject: subject)
    end 
  end
end