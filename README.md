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


Place a call in the controller where notifications should be created to loop through users emails, after the notifcation is saved:

	@users = User.all 
    @users.each do |u| 
      Notifier.new_notification(u.email).deliver_now
    end


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerlichten/simply_notify.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


