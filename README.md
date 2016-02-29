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

Create the model and views using the generator:

	rails generate notifier


Place a call in the controller in which you want notifications to be created. For example, if you want each user to be notified when an assignment is created, use a call such as this:

	@users = User.all 
    @users.each do |u| 
      Notifier.new_notification(u.email).deliver_now
    end


Add config SMTP code to appropriate environments. For example, sending emails from a gmail account:

    # SMTP Config
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true 
    config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'gmail.com',
    user_name:            'YOUR_USERNAME@gmail.com',
    password:             'YOUR_PASSWORD',
    authentication:       'plain',
    enable_starttls_auto: true  }


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerlichten/simply_notify.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


