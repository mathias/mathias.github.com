---
layout: post
title: Getting MongoDB and Devise to play well on Rails 3
published: true
redirect_from:
  - /blog/2011/01/03/getting-mongodb-and-devise-to-play-well-on-rails-3/
---

While there's a [good guide](http://www.mongodb.org/display/DOCS/Rails+3+-+Getting+Started) on the MongoDB site about getting mongo_mapper to work in Rails 3, I ran into some additional issues getting the popular [devise](https://github.com/plataformatec/devise) authentication engine for Rails to work with Mongo. This documents how to create a Rails app from scratch that uses both MongoDB and Devise. So if you don't want to reinvent the wheel on authentication (read: Users, login, logout, etc) and want to run your app on MongoDB, this should be useful.

First of all, you'll need Rails 3\. I'm on Rails 3.0.3\. I created a new gemset for this app, just to keep things clean. Run the rails new command with the `--skip-active-record` switch.

```
$ rails new awesome_app --skip-active-record
```

Open up the Gemfile of the new app. It's going to be pretty empty to start. This is what I ended up with, after reading the Mongo guide mentioned at the beginning of the post:

{% highlight ruby %}
require 'rubygems'
require 'mongo'

source :rubygems

gem 'mongo_mapper'
gem 'rails', '3.0.3'
gem 'devise', '1.1.3'
gem 'devise-mongo_mapper',
  :git    => 'git://github.com/collectiveidea/devise-mongo_mapper'

group :test, :development do
  [whatever testing gems you want in here]
end
{% endhighlight %}

You'll notice the devise-mongo_mapper gem in there. That's the secret sauce that lets us use mongo_mapper as the ORM for Devise. As I haven't really played with the mongoid gem (and therefore don't have any experience with it) I didn't try to get mongoid to work.

Go ahead and run a bundle install:

```
$ bundle install
```

Then run this to install devise files into the Rails app:

```
$ rails generate devise:install
```

There's two initializer files we'll need. We add the one for mongo, which I put in config/initializers/mongo.rb:

{% highlight ruby %}
MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "awesome-app-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end
{% endhighlight %}

And one for devise, which you'll find created for you in config/initializers/devise.rb. Change the ORM Configuration settings to this:

{% highlight ruby %}
# ==>; ORM configuration
# Load and configure the ORM. Supports :active_record (default) and
# :mongoid (bson_ext recommended) by default. Other ORMs may be
# available as additional gems.
  require 'devise/orm/mongo_mapper'
{% endhighlight %}

Be sure to add this line to config/application.rb and edit in the appropriate address. This will keep Devise from complaining later:

```
config.action_mailer.default_url_options = { :host => "yourdomain.com" }
```

The last step is to create an User model and tell Devise and mongo_mapper to do their thing. Tell Devise to make a Users model and then install the Devise Views to our app so that we can modify them later, if we wish:

```
$ rails generate devise users
$ rails generate devise:views
```

In app/models/user.rb:

{% highlight ruby %}
class User
  include MongoMapper::Document
  plugin MongoMapper::Devise

  devise :database_authenticatable, :confirmable, :lockable,
         :recoverable, :rememberable, :registerable, :trackable,
         :timeoutable, :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation

end
{% endhighlight %}

You can, of course, choose which of those Devise options to enable for your user model. Refer to the [devise documentation](http://rubydoc.info/github/plataformatec/devise/master/Devise/Models) for more information.

In app/controllers/application_controller.rb:

{% highlight ruby %}
class ApplicationController < ActionController::Base
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
{% endhighlight %}

In config/routes.rb add these lines:

{% highlight ruby %}
devise_for :users, :admin
resource :user
{% endhighlight %}

At this point, you should probably check your app by running a quick `rails server` and seeing it if spits out any errors to your terminal. If it's all good, then you are probably thinking you'll want to actually use this authentication system now. Let's add a very basic "Home" controller:

```
$ rails generate controller Home index token
```

In app/controllers/home_controller.rb, add the following before_filter line to the beginning of the class so that it looks like this:

{% highlight ruby %}
class HomeController < ApplicationController
  before_filter :authenticate_user!, :only => :token

  def index
  end

  def token
  end

end
{% endhighlight %}

In app/views/home/index.haml (I'm using HAML, but I've also included an ERb example after this:

{% highlight haml %}
- if user_signed_in?
  %ul
    %li= current_user.email
    %li= link_to 'My info', edit_user_path
    %li= link_to 'Sign out', destroy_user_session_path
- else
  %ul
    %li= link_to 'Sign in', new_user_session_path
    %li= link_to 'Sign up', new_user_path
{% endhighlight %}

{% highlight erb %}
# ERb version of app/views/home/index.html.erb:
<% if user_signed_in? -%>
  <ul>
    <li><%= current_user.email %></li>
    <li><%= link_to 'My info', edit_user_registration_path %></li>
    <li><%= link_to 'Sign out', destroy_user_session_path %></li>
  </ul>
<% else -%>
  </code><ul><code>
    <li><%= link_to 'Sign in', new_user_session_path %></li>
    <li><%= link_to 'Sign up', new_user_path %></li>
<% end -%>
{% endhighlight %}

This will enable very basic login / logouts using the Devise views that we installed earlier. If you run rails server again, you'll be able to create an account. But, if your system isn't set up to send mail (like mine) then you may get an error, or simply won't get a confirmation code, so you won't be able to login with that user. Here's a quick solution. Drop into the mongo shell:

```
$ mongo
MongoDB shell version: 1.6.4
```

Use your database, which you set above in config/initializers/mongo.rb. In this case, it's awesome-app-development:

```
> use awesome-app-development
switched to db awesome-app-development
```

Find all the entries in the Users document:

```
> db.users.find();
{ "_id" : ObjectId("4d216ae217cacc289c000005"), "email" : "matt.gauger@gmail.com", "encrypted_password" : "$2aasdf", "password_salt" : "$2aasdf", "authentication_token" : null, "remember_token" : null, "remember_created_at" : null, "reset_password_token" : null, "confirmation_token" : "YsFg8CFBwNIm5kof7xC9", "confirmed_at" : null, "confirmation_sent_at" : "Mon Jan 03 2011 00:21:22 GMT-0600 (CST)", "failed_attempts" : 0, "unlock_token" : null, "locked_at" : null, "sign_in_count" : 0, "current_sign_in_at" : null, "last_sign_in_at" : null, "current_sign_in_ip" : null, "last_sign_in_ip" : null }
```

The bit we need is the confirmation_token: "YsFg8CFBwNIm5kof7xC9". Copy the token and go to the following in your browser:

```
http://localhost:3000/users/confirmation?confirmation_token=YsFg8CFBwNIm5kof7xC9
```

Remember to replace your token with the one in that URL. You could alternatively make it so your app can send mail, or just turn off :confirmable in your Users model. This was a quick little solution that I found and wanted to share.

Hopefully this gets you going with Mongo and Devise quickly and without any snags. There's a lot more to Devise, so I'd recommend you start looking at some of the [Example applications](https://github.com/plataformatec/devise/wiki/Example-Applications) and the [documentation](https://github.com/plataformatec/devise/wiki).
