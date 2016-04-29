# SimplyNotify

simply_notify allows users to set preferences on how they want to receive notifications. Notifications are sent to users via email using actionmailer. Users can set their account preferences to receive notifications either in real time or a list of notifications every 24 hours. Ahoy_email is used for email tracking. For more information on gem dependncies of simply_notify, check out the additional information section. 

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

Generate mailer, views, and ahoy_email initializer.

	$ rails generate notifier

###Step 2

Generate ahoy_messages table.
    
    $ rails generate ahoy_email:install
    $ rake db:migrate

###Step 3

Generate notifications table.

    $ rails g migration add_notificationFrequency_to_users notifificationFrequency:integer
    $ rake db:migrate

notificationFrequency values:
nil or 0 = user does not receive notifications via email
1 = user receives notifications in real time via email
2 = user receives a list of notifications every 24 hours via email

###Step 4

Generate notifications model.
    
    $ rails g model Notification recipient_id:integer creator_id:integer action:string url:string
    $ rake db:migrate

###Step 5 

Generate notifications controller.

    $ rake g controller notifications

###Step 6

Generate config/schedule.rb for cron jobs. 
    
    $ cd /apps/my-great-project
    $ wheneverize .

###Step 7

Add create/mailer to create method in appropriate controllers, such as this example in controllers/assignments_controller.rb.

    if Assignment.where(:id) != nil
      most_recent_id = Assignment.maximum(:id).next
    else 
      most_recent_id = 1
    end 
    url = "http://localhost:3000/posts?assignment_id=#{most_recent_id}"
    @users = User.all 
    @users.each do |u| 
      Notification.create(recipient: u, action: "New Assignment", url: url)
      if (u.notificationFrequency == 1 || u.admin == true)
        # use nil as parameter if you want link to be homepage, can also use url 
        # change title of email by changing 'Notifications'
        Notifier.new_notification(u, nil, 'Notifications').deliver_now
      end 
    end

###Step 8

Configure SMTP settings for sending from gmail account and set homepage as absolute url (add to appropriate environments, such as config/environments/development.rb).

    # SMTP Config
    config.absolute_site_url = 'http://localhost:3000/' #Set as your homepage  
    config.action_mailer.default_options = { 
    from: "YOUR_FROM_EMAIL@gmail.com" #Set as your from email 
    }  
    config.action_mailer.default_url_options = {:host => "localhost:3000"} #Set as the host
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.perform_deliveries = true 
    config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'gmail.com',
    user_name:            'YOUR_USERNAME@gmail.com', #Set as your email
    password:             'YOUR_PASSWORD', #Set as your password
    authentication:       'plain',
    enable_starttls_auto: true  }

###Step 9

Edit configure_permitted_parameters method in controllers/application_controller.rb

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :password_confirmation, :optout, :nickname, :notificationFrequency) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :password_confirmation, :optout, :nickname, :notificationFrequency, :current_password) }
    end

###Step 10 

Add radio buttons to view/devise/registrations/edit.html.erb form.

    <div class="field">
      <h2>Notification Frequency</h2>
      <p>Select from one of the options below:</p>
      <%= f.radio_button :notificationFrequency, nil %>
      <%= f.label("I do not want to receive notifications by email") %></br>
      <%= f.radio_button :notificationFrequency, 1 %>
      <%= f.label("I want to receive a single notification by email every time a new notifcation appears on my account") %></br>
      <%= f.radio_button :notificationFrequency, 2 %>
      <%= f.label("I want to receive a list of notifications for my account by email every 24 hours") %></br>
    </div>

Add radio buttons to view/devise/registrations/new.html.erb form.

    <div class="field">
      <h2>Notification Frequency</h2>
      <p>Select from one of the options below (this can be changed in your profile preferences at any time):</p>
      <%= f.radio_button :notificationFrequency, nil %>
      <%= f.label("I do not want to receive notifications by email") %></br>
      <%= f.radio_button :notificationFrequency, 1 %>
      <%= f.label("I want to receive a single notification by email every time a new notifcation appears on my account") %></br>
      <%= f.radio_button :notificationFrequency, 2 %>
      <%= f.label("I want to receive a list of notifications for my account by email every 24 hours") %></br>
    </div>

###Step 11

Setup cron job frequency in config/schedule.rb.

    every 1.day, :at => '8:00 pm' do
      rake "cron:deliver_emails"
    end

Create file as lib/tasks/cron.rake and set rake schedule.

    namespace :cron do
      desc "Send notification emails every 24 hours"
      task deliver_emails: :environment do
        users = User.where(notificationFrequency: 2)
        users.each do |u|
          Notifier.new_notification(u, nil, 'Daily Notifications').deliver_now 
        end
      end
    end

###Step 12 

Add associations to Notification model in model/notification.rb.

    belongs_to :recipient, class_name: "User"
    belongs_to :creator, class_name: "User"

Add associations to User model in model/user.rb.

    has_many :notifications

Add associations to any other models in which notifications are generated in their respective controllers.

    has_many :notifications

###Step 13

Add route to config/routes.rb.

    resources :notifications

###Step 14

Add to notifications controller.

    cclass NotificationsController < ApplicationController
      before_action :authenticate_user!

      def index
        @notifications = Notification.where(recipient: current_user)
      end
    end

# Additional Information

Check out the ahoy_email gem for more information on email analytics --> https://github.com/ankane/ahoy_email

Check out the whenever gem for more information on cron jobs --> https://github.com/javan/whenever

Check out the devise gem for more information on user authentication --> https://github.com/plataformatec/devise

###Important Note for Email Tracking

If you are using a localhost for development, such as localhost:3000, you will need to allow your system to be reachable from the outside in order to populate data into the ahoy_messages table for opened_at tracking. When the user opens their email, the image tag is fetched from your application server. The system must be reachable or it won't updated ahoy. Values will appear as 'nil' in the table. A service such as pagekite will do the trick!

# Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tylerlichten/simply_notify.

# License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


