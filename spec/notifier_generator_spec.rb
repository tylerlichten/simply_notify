require 'spec_helper_generator'
require 'generator_spec'

describe NotifierGenerator, type: :generator do
  before(:all) do
    prepare_destination
    run_generator
  end

  it "creates Model" do
    assert_file "app/models/notifier.rb", "require 'simply_notify'"
  end

  it "creates View for html" do
    assert_file "app/views/notifier/new_notification.html.erb", 
    "<!DOCTYPE html>
      <html>
        <head>
          <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
        </head>
        <body>
          <h1>Hello <%= @recipient %></h1>
          <p>
            You have a new notification! Please visit the course website.<br>
            Thanks.<br>
          </p>
        </body>
      </html>"
  end

  it "creates View for text" do
    assert_file "app/views/notifier/new_notification.text.erb", 
     "Hello <%= @recipient %>, 
      You have a new notification! Please visit the course website.
      Thanks."
  end
end