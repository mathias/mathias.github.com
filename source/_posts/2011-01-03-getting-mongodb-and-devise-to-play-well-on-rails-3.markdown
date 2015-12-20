---
layout: post
title: Getting MongoDB and Devise to play well on Rails 3
published: true
redirect_from:
  - /blog/2011/01/03/getting-mongodb-and-devise-to-play-well-on-rails-3/
---
<p>While there's a <a href="http://www.mongodb.org/display/DOCS/Rails+3+-+Getting+Started">good guide</a> on the MongoDB site about getting mongo_mapper to work in Rails 3, I ran into some additional issues getting the popular <a href="https://github.com/plataformatec/devise">devise</a>&nbsp;<span style="font-family: helvetica, arial, freesans, clean, sans-serif; line-height: 20px;">authentication engine for Rails to work with Mongo. This documents how to create a Rails app from scratch that uses both MongoDB and Devise. So if you don't want to reinvent the wheel on authentication (read: Users, login, logout, etc) and want to run your app on MongoDB, this should be useful.</span></p>
<p><span style="font-family: helvetica, arial, freesans, clean, sans-serif; line-height: 20px;">First of all, you'll need Rails 3. I'm on Rails 3.0.3. I created a new gemset for this app, just to keep things clean. Run the rails new command with the&nbsp;</span><span style="font-family: Courier New, Courier, monospace; line-height: 16px;">--skip-active-record </span>switch.</p>
<div class="CodeRay">
  <div class="code"><pre>$ rails new awesome_app --skip-active-record</pre></div>
</div>

<p>Open up the Gemfile of the new app. It's going to be pretty empty to start. This is what I ended up with, after reading the Mongo guide mentioned at the beginning of the post:</p>
<div class="CodeRay">
  <div class="code"><pre>require 'rubygems'
require 'mongo'

source :rubygems

gem 'mongo_mapper'
gem 'rails', '3.0.3'
gem 'devise', '1.1.3'
gem 'devise-mongo_mapper',
  :git    =&gt; 'git://github.com/collectiveidea/devise-mongo_mapper'

group :test, :development do
  [whatever testing gems you want in here]
end</pre></div>
</div>

<p>You'll notice the devise-mongo_mapper gem in there. That's the secret sauce that lets us use mongo_mapper as the ORM for Devise. As I haven't really played with the mongoid gem (and therefore don't have any experience with it) I didn't try to get mongoid to work.</p>
<p>Go ahead and run a bundle install:</p>
<div class="CodeRay">
  <div class="code"><pre>$ bundle install</pre></div>
</div>

<p>Then run this to install devise files into the Rails app:</p>
<div class="CodeRay">
  <div class="code"><pre>$ rails generate devise:install</pre></div>
</div>

<p>There's two initializer files we'll need. We add the one for mongo, which I put in config/initializers/mongo.rb:</p>
<div class="CodeRay">
  <div class="code"><pre>MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = &quot;awesome-app-#{Rails.env}&quot;

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect_to_master if forked
   end
end</pre></div>
</div>

<p>And one for devise, which you'll find created for you in config/initializers/devise.rb. Change the ORM Configuration settings to this:</p>
<div class="CodeRay">
  <div class="code"><pre># ==&gt;; ORM configuration
# Load and configure the ORM. Supports :active_record (default) and
# :mongoid (bson_ext recommended) by default. Other ORMs may be
# available as additional gems.
  require 'devise/orm/mongo_mapper'</pre></div>
</div>

<p>Be sure to add this line to config/application.rb and edit in the appropriate address. This will keep Devise from complaining later:</p>
<div class="CodeRay">
  <div class="code"><pre>config.action_mailer.default_url_options = { :host =&gt; &quot;yourdomain.com&quot; }</pre></div>
</div>

<p>The last step is to create an User model and tell Devise and mongo_mapper to do their thing. Tell Devise to make a Users model and then install the Devise Views to our app so that we can modify them later, if we wish:</p>
<div class="CodeRay">
  <div class="code"><pre>$ rails generate devise users
$ rails generate devise:views</pre></div>
</div>

<p>In app/models/user.rb:</p>
<div class="CodeRay">
  <div class="code"><pre>class User
  include MongoMapper::Document
  plugin MongoMapper::Devise

  devise :database_authenticatable, :confirmable, :lockable,
         :recoverable, :rememberable, :registerable, :trackable,
         :timeoutable, :validatable, :token_authenticatable

  attr_accessible :email, :password, :password_confirmation

end</pre></div>
</div>

<p>You can, of course, choose which of those Devise options to enable for your user model. Refer to the <a href="http://rubydoc.info/github/plataformatec/devise/master/Devise/Models">devise documentation</a> for more information.</p>
<p>In app/controllers/application_controller.rb:</p>
<div class="CodeRay">
  <div class="code"><pre>class ApplicationController &lt; ActionController::Base
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end</pre></div>
</div>

<p>In config/routes.rb add these lines:</p>
<div class="CodeRay">
  <div class="code"><pre>devise_for :users, :admin
resource :user</pre></div>
</div>

<p>At this point, you should probably check your app by running a quick `rails server` and seeing it if spits out any errors to your terminal. If it's all good, then you are probably thinking you'll want to actually use this authentication system now. Let's add a very basic "Home" controller:</p>
<div class="CodeRay">
  <div class="code"><pre>$ rails generate controller Home index token</pre></div>
</div>

<p>In app/controllers/home_controller.rb, add the following before_filter line to the beginning of the class so that it looks like this:</p>
<div class="CodeRay">
  <div class="code"><pre>class HomeController &lt; ApplicationController
  before_filter :authenticate_user!, :only =&gt; :token

  def index
  end

  def token
  end

end</pre></div>
</div>

<p>In app/views/home/index.haml (I'm using HAML, but I've also included an ERb example after this:</p>
<div class="CodeRay">
  <div class="code"><pre>- if user_signed_in?
  %ul
    %li= current_user.email
    %li= link_to 'My info', edit_user_path
    %li= link_to 'Sign out', destroy_user_session_path
- else
  %ul
    %li= link_to 'Sign in', new_user_session_path
    %li= link_to 'Sign up', new_user_path</pre></div>
</div>

<div class="CodeRay">
  <div class="code"><pre># ERb version of app/views/home/index.html.erb:
&lt;% if user_signed_in? -%&gt;
  &lt;ul&gt;
    &lt;li&gt;&lt;%= current_user.email %&gt;&lt;/li&gt;
    &lt;li&gt; link_to 'My info', edit_user_registration_path %&gt;&lt;/li&gt;
    &lt;li&gt;&lt;%= link_to 'Sign out', destroy_user_session_path %&gt;&lt;/li&gt;
  &lt;/ul&gt;
&lt;% else -%&gt;
  &lt;/code&gt;&lt;ul&gt;&lt;code&gt;
    &lt;li&gt;&lt;%= link_to 'Sign in', new_user_session_path %&gt;&lt;/li&gt;
    &lt;li&gt;&lt;%= link_to 'Sign up', new_user_path %&gt;&lt;/li&gt;
&lt;% end -%&gt;</pre></div>
</div>

<p>This will enable very basic login / logouts using the Devise views that we installed earlier. If you run rails server again, you'll be able to create an account. But, if your system isn't set up to send mail (like mine) then you may get an error, or simply won't get a confirmation code, so you won't be able to login with that user. Here's a quick solution. Drop into the mongo shell:</p>
<div class="CodeRay">
  <div class="code"><pre>$ mongo
MongoDB shell version: 1.6.4</pre></div>
</div>

<p>Use your database, which you set above in config/initializers/mongo.rb. In this case, it's awesome-app-development:</p>
<div class="CodeRay">
  <div class="code"><pre>&gt; use awesome-app-development
switched to db awesome-app-development</pre></div>
</div>

<p>Find all the entries in the Users document:</p>
<div class="CodeRay">
  <div class="code"><pre>&gt; db.users.find();
{ &quot;_id&quot; : ObjectId(&quot;4d216ae217cacc289c000005&quot;), &quot;email&quot; : &quot;matt.gauger@gmail.com&quot;, &quot;encrypted_password&quot; : &quot;$2aasdf&quot;, &quot;password_salt&quot; : &quot;$2aasdf&quot;, &quot;authentication_token&quot; : null, &quot;remember_token&quot; : null, &quot;remember_created_at&quot; : null, &quot;reset_password_token&quot; : null, &quot;confirmation_token&quot; : &quot;YsFg8CFBwNIm5kof7xC9&quot;, &quot;confirmed_at&quot; : null, &quot;confirmation_sent_at&quot; : &quot;Mon Jan 03 2011 00:21:22 GMT-0600 (CST)&quot;, &quot;failed_attempts&quot; : 0, &quot;unlock_token&quot; : null, &quot;locked_at&quot; : null, &quot;sign_in_count&quot; : 0, &quot;current_sign_in_at&quot; : null, &quot;last_sign_in_at&quot; : null, &quot;current_sign_in_ip&quot; : null, &quot;last_sign_in_ip&quot; : null }</pre></div>
</div>

<p>The bit we need is the confirmation_token: "YsFg8CFBwNIm5kof7xC9". Copy the token and go to the following in your browser:</p>
<div class="CodeRay">
  <div class="code"><pre>http://localhost:3000/users/confirmation?confirmation_token=YsFg8CFBwNIm5kof7xC9</pre></div>
</div>

<p>Remember to replace your token with the one in that URL. You could alternatively make it so your app can send mail, or just turn off :confirmable in your Users model. This was a quick little solution that I found and wanted to share.</p>
<p>&nbsp;</p>
<p>Hopefully this gets you going with Mongo and Devise quickly and without any snags.&nbsp;There's a lot more to Devise, so I'd recommend you start looking at some of the <a href="https://github.com/plataformatec/devise/wiki/Example-Applications">Example applications</a>&nbsp;and the <a href="https://github.com/plataformatec/devise/wiki">documentation</a>.</p>