# SimplyNotify

simply_notify will send a user of the Brandeis University course website an email notifying the user of a new notification that has been posted to their account. 


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simply_notify'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simply_notify


## Usage

Step 1: Generate mailer and views.

	rails generate notifier


Step 2: Setup controller where you want then notifications to be created and URL link information. 

For example, if you want each user to be notified when an assignment is created and a link to the homepage included in the email, use a call such as this (added to app/controllers/assignments_controller.rb)

    # simply_notify: Most recent ID
    most_recent_id = Assignment.maximum('id')

    # simply_notify: Notification source URL link 
    url = "http://localhost:3000/assignments/postlist?id=#{most_recent_id}"

    # simply_notify: Deliver email to each user
    # use nil as parameter if you want url link to be the homepage
    # use url as parameter if you want url link to be the source of the notification
    @users = User.all 
    @users.each do |u| 
      Notifier.new_notification(u.email, url).deliver_now
    end


Step 3: Configure SMTP settings and set homepage as absolute url.

For example, sending emails from a gmail account (added to appropriate environments, such as config/environments/development.rb):

    # SMTP Config
    config.absolute_site_url = 'http://localhost:3000/'  #set as your homepage
    config.action_mailer.default_options = {
    from: "YOUR_FROM_EMAIL@gmail.com"  #set as your from email
    }
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true 
    config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'gmail.com',
    user_name:            'YOUR_USERNAME@gmail.com',  #set as your email
    password:             'YOUR_PASSWORD',  #set as your password
    authentication:       'plain',
    enable_starttls_auto: true  }


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerlichten/simply_notify.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


