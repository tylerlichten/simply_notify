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
          <h1>Hello</h1>
          <p>
            A new assignment has been posted!<br><br>
            Please visit the course website: <%= @url %><br><br>
            Thanks!<br>
          </p>
        </body>
      </html>"
  end

  def create_text_view_file
    create_file "app/views/notifier/new_notification.text.erb", 
    "Hello, 
      A new assignment has been posted! 
      Please visit the course website: <%= @url %>.
      
      Thanks!"
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
      "has_many :messages, class_name: \"Ahoy::Message\"",
      after: "has_many :groups, through: :memberships"
  end 
end
