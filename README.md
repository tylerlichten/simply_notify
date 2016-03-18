# SimplyNotify

simply_notify will send a user of the website an email notifying the user of a new notification that has been posted to their user account. It will also provide a link to the notifcation source (or homepage) and also track analytics such as when the user opens the notification email. 

Check out ahoy_email for more information on email analytics --> https://github.com/ankane/ahoy_email


# Installation

Add this line to your application's Gemfile:

```ruby
gem 'simply_notify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simply_notify


# Usage

###Step 1

Generate Notifier Mailer, Notifier Views, and ahoy_email Initializer.

	rails generate notifier


###Step 2

Generate ahoy_messages table.
    
    rails generate ahoy_email:install
    rake db:migrate


###Step 3

Setup controller where you want the notifications to be created.

For example, if you want each user to be notified when an assignment is created, a link to the homepage included in the email, and the email subject to be 'New Assignment Posted' use a call such as this (added to app/controllers/assignments_controller.rb)

    # simply_notify: Most recent ID
    most_recent_id = Assignment.maximum('id')

    # simply_notify: Notification source URL link 
    url = "http://localhost:3000/assignments/postlist?id=#{most_recent_id}"

    # simply_notify: Deliver email to each user
    # use nil as parameter if you want url link to be the homepage
    # use url as parameter if you want url link to be the source of the notification
    @users = User.all 
    @users.each do |u| 
      Notifier.new_notification(u, url, 'New Assignment Posted').deliver_now
    end


###Step 4

Configure SMTP settings and set homepage as absolute url.

For example, sending emails from a gmail account (added to appropriate environments, such as config/environments/development.rb):

    # SMTP Config
    # Set as your homepage
    config.absolute_site_url = 'http://localhost:3000/'     
    # Set as your from email 
    config.action_mailer.default_options = {
    from: "YOUR_FROM_EMAIL@gmail.com"  
    }
    # Set as the host
    config.action_mailer.default_url_options = {:host => "localhost:3000"} 
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true 
    config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'gmail.com',
    # Set as your email
    user_name:            'YOUR_USERNAME@gmail.com',
    # Set as your password
    password:             'YOUR_PASSWORD', 
    authentication:       'plain',
    enable_starttls_auto: true  }


###IMPORTANT NOTE 

If you are using a localhost for development, such as localhost:3000, you will need to allow your system to be reachable from the outside in order to populate data into ahoy_messages table for opened_at. When the user opens their email, the image tag is fetched from your application server. The system must be reachable or it won't updated ahoy and values will appear as 'nil' in the table. 

A service such as pagekite will do the trick!


# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerlichten/simply_notify.


# License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


