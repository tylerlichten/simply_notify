require "rails/generators"
require "thor"

class NotifierGenerator < Rails::Generators::Base
  desc "This generator creates the Mailer and Views"

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
end
