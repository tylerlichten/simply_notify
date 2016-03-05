require 'spec_helper_generator'
require 'generator_spec'

describe NotifierGenerator, type: :generator do
  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates Mailer" do
    assert_file "app/mailers/notifier.rb", "require 'simply_notify'"
  end

  it "creates View for html" do
    assert_file "app/views/notifier/new_notification.html.erb", 
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

  it "creates View for text" do
    assert_file "app/views/notifier/new_notification.text.erb", 
     "Hello, 
      A new assignment has been posted! 
      Please visit the course website: <%= @url %>.
      
      Thanks!"
  end
end