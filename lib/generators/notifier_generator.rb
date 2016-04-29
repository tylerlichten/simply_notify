require "rails/generators"
require "thor"

class NotifierGenerator < Rails::Generators::Base
  desc "This generator creates the Notifier Mailer, Notifier Views, and ahoy_email initializer"

  def create_mailer_file
  	create_file "app/mailers/notifier.rb", "require 'simply_notify'"
  end 

  def create_html_view_file
    create_file "app/views/notifier/new_notification.html.erb", 
    "<!DOCTYPE html>
    <html>
      <head>
        <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
        </head>
        <body>
          <h1>Hello!</h1>
          <p>
            If your account has new notifications, they will be lised below.<br><br>
            Please visit the course website at: <%= @url %><br>
            Or you can follow the links provided by the notifications.<br><br>
            Thanks!<br>

        <% if @recipient.notificationFrequency == 2 && @recipient.admin == false %>
          <h1>List of Notifications (past 24 hours):</h1>
          <% i = 0 %>
          <% @notifications.each do |x| %>
            <% if x.recipient_id == @recipient.id && x.created_at >= 1.day.ago %>
              <% i += 1 %>
              <%= i %>.
              <%= x.action %> -- 
              <%= x.url %>
              <br>
            <% end %>
          <% end %>
        <% elsif @recipient.notificationFrequency == 1 && @recipient.admin == false %>
          <h1>New Notification:</h1>
          <% @notifications.reverse.each do |x| %>
            <% if x.recipient_id == @recipient.id %>
              <%= x.action %> --
              <%= x.url %>
              <% break %>
            <% end %>
          <% end %>
        <% elsif @recipient.admin == true %> 
          <h1>List of all Notifications (past 24 hours):</h1>
          <% i = 0 %>
          <% @notifications.each do |x| %>
            <% if x.created_at >= 1.day.ago %>
              <% i += 1 %>
              <%= i %>. User ID  
              <%= x.recipient_id %> --
              <%= x.action %> -- 
              <%= x.url %>
              <br>
            <% end %>
          <% end %>
        <% end %> 
        </p>
      </body>
    </html>"
  end

  def create_text_view_file
    create_file "app/views/notifier/new_notification.text.erb", 
    "Hello, 
      If your account has new notifications, they will be lised below.
      Please visit the course website at: <%= @url %>
      Or you can follow the links provided by the notifications.
      
      Thanks!

        <% if @recipient.notificationFrequency == 2 && @recipient.admin == false %>
          List of Notifications (past 24 hours): 
          <% i = 0 %>
          <% @notifications.each do |x| %>
            <% if x.recipient_id == @recipient.id && x.created_at >= 1.day.ago %>
              <% i += 1 %>
              <%= i %>.
              <%= x.action %> -- 
              <%= x.url %>
              \r\n
            <% end %>
          <% end %>
        <% elsif @recipient.notificationFrequency == 1 && @recipient.admin == false %>
          New Notification:
          <% @notifications.reverse.each do |x| %>
            <% if x.recipient_id == @recipient.id %>
              <%= x.action %> --
              <%= x.url %>
              <% break %>
            <% end %>
          <% end %>
        <% elsif @recipient.admin == true %> 
          List of all Notifications (past 24 hours):
          <% i = 0 %>
          <% @notifications.each do |x| %>
            <% if x.created_at >= 1.day.ago %>
              <% i += 1 %>
              <%= i %>. User ID  
              <%= x.recipient_id %> --
              <%= x.action %> -- 
              <%= x.url %>
              \r\n
            <% end %>
          <% end %>
        <% end %>"
  end

  def create_ahoy_email_initializer
    create_file "config/initializers/ahoy_email.rb",
    "class EmailSubscriber

      def open(event)
        # :message and :controller keys
        ahoy = event[:controller].ahoy
        ahoy.track \"Email opened\", message_id: event[:message].id
      end

      def click(event)
        # same keys as above, plus :url
        ahoy = event[:controller].ahoy
        ahoy.track \"Email clicked\", message_id: event[:message].id, url: event[:url]
      end
    end

    AhoyEmail.subscribers << EmailSubscriber.new"
  end

  def insert_association_user_model
    insert_into_file "app/models/user.rb",
      "\n  has_many :messages, class_name: \"Ahoy::Message\"",
      after: "class User < ActiveRecord::Base"
  end 
end
