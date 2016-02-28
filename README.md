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

In the views (text and html respectively), place a message such as this:
	
	Hello <%= @recipient %>,
	You have a new notification! Please visit the course website.
	Thanks.

	AND

	<!DOCTYPE html>
	<html>
  	  <head>
        <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
      </head>
      <body>
        <h1>Hello <%= @user.name %></h1>
        <p>
          You have a new notification! Please visit the course website.<br>
          Thanks.<br>
        </p>
      </body>
    </html>


Finally, call a variation of this from the controller where notifications are created, right after the notifcation is saved:

	Notifier.new_notification(@recipient).deliver_now


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerlichten/simply_notify.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


