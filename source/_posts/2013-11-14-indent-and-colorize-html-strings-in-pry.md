---
layout: post
title: "Indent and colorize HTML strings in pry"
date: 2013-11-14 11:32
redirect_from:
  - /blog/2013/11/14/indent-and-colorize-html-strings-in-pry/
---

---

*(This post is part of my blog archiving project. This post appeared on [Coderwall](https://coderwall.com/p/hlbana) on November 14, 2013.)*

---

An issue I run into frequently while testing with tools like [capybara](https://github.com/jnicklas/capybara) by dropping into [pry](http://pryrepl.org/) is that the last response for a page is a single string, containing the HTML that was rendered. But those string have lost indentation and generally make it really hard to see the content of the page, or whatever you care about.

For example, a simple login page might look like:

```shell
pry »  page.body
=> "<!DOCTYPE html><html><head><title>Mysite</title><link data-turbolinks-track=\"true\" href=\"/assets/application.css\" media=\"all\" rel=\"stylesheet\" /><script data-turbolinks-track=\"true\" src=\"/assets/application.js\"></script></head><body><div class=\"content\"><h1><a href=\"/\">Mysite</a></h1><nav class=\"primary\"><ul class=\"main\"><li class=\"main\"><a href=\"/users/sign_in\">Log In/Sign Up</a></li><li class=\"main\"><a class=\"text\" href=\"#\">About</a></li></ul></nav></div><div class=\"content\"><h2>Log In</h2><div class=\"full_page_form\"><form accept-charset=\"UTF-8\" action=\"/users/sign_in\" class=\"half\" id=\"new_user\" method=\"post\"><div style=\"margin:0;padding:0;display:inline\"><input name=\"utf8\" type=\"hidden\" value=\"&#x2713;\" /></div><fieldset><div class=\"form-field email \"><label for=\"user_email\">Email</label><input autofocus=\"autofocus\" id=\"user_email\" name=\"user[email]\" type=\"email\" value=\"\" /></div><div class=\"form-field password \"><label for=\"user_password\">Password</label><input id=\"user_password\" name=\"user[password]\" type=\"password\" /></div><div class=\"form-field remember_me \"><input name=\"user[remember_me]\" type=\"hidden\" value=\"0\" /><input id=\"user_remember_me\" name=\"user[remember_me]\" type=\"checkbox\" value=\"1\" /><label class=\"inline\" for=\"user_remember_me\">Remember me</label></div><div class=\"form-field submit\"><button class=\"secondary\" name=\"button\" type=\"submit\">Log In</button></div><p class=\"forgot-password\"><a href=\"/users/password/new\">Forgot your Password?</a></p></fieldset></form><div class=\"second-half\"><h3>Coming soon!</h3><p>Soon, you'll be able to log in with Facebook...</p></div></div><div class=\"call-to-action-button\"><a href=\"/sign_up\">New to Mysite? Sign up for an account to get goin&#39;!</a></div></div><footer><div class=\"content\"></footer></body></html>"
```

Wouldn't it be great if Pry could re-indent and colorize that string of HTML for you? Well, I put together a quick little Pry command that does. Throw this into your `~/.pryrc`:

```ruby
Pry::Commands.create_command "html5tidy" do
  description "Print indented, colorized HTML from the input: html5tidy [ARGS]"

  command_options requires_gem: ['nokogiri']

  def process
    @object_to_interrogate = args.empty? ? target_self : target.eval(args.join(" "))
    cleaned_html = Nokogiri::XML(@object_to_interrogate,&:noblanks)

    colorized_text = Pry.config.color ? CodeRay.scan(cleaned_html, :html).term : cleaned_html
    output.puts colorized_text
  end
end
```

Originally, I had tried to use the html5 fork of the `tidy` command: [https://github.com/w3c/tidy-html5](https://github.com/w3c/tidy-html5) but that tool *changes* the HTML as it parses it, and spits out a bunch of warnings. So instead, I have this pry command use `nokogiri` when it is available. The command should warn you if you try to use it without `nokogiri` available. What is output should be very close to the original rendered HTML, just cleaned up and re-indented.

So what does it look like in action?

```xml
pry »  html5tidy page.body
<?xml version="1.0"?>
<!DOCTYPE html>
<html>
  <head>
    <title>Mysite</title>
    <link data-turbolinks-track="true" href="/assets/application.css" media="all" rel="stylesheet"/>
    <script data-turbolinks-track="true" src="/assets/application.js"/>
  </head>
  <body>
    <div class="content">
      <h1>
        <a href="/">Mysite</a>
      </h1>
      <nav class="primary">
        <ul class="main">
          <li class="main">
            <a href="/users/sign_in">Log In/Sign Up</a>
          </li>
          <li class="main">
            <a class="text" href="#">About</a>
          </li>
        </ul>
      </nav>
    </div>
    <div class="content">
      <h2>Log In</h2>
      <div class="full_page_form">
        <form accept-charset="UTF-8" action="/users/sign_in" class="half" id="new_user" method="post">
          <div style="margin:0;padding:0;display:inline">
            <input name="utf8" type="hidden" value="&#x2713;"/>
          </div>
          <fieldset>
            <div class="form-field email ">
              <label for="user_email">Email</label>
              <input autofocus="autofocus" id="user_email" name="user[email]" type="email" value=""/>
            </div>
            <div class="form-field password ">
              <label for="user_password">Password</label>
              <input id="user_password" name="user[password]" type="password"/>
            </div>
            <div class="form-field remember_me ">
              <input name="user[remember_me]" type="hidden" value="0"/>
              <input id="user_remember_me" name="user[remember_me]" type="checkbox" value="1"/>
              <label class="inline" for="user_remember_me">Remember me</label>
            </div>
            <div class="form-field submit">
              <button class="secondary" name="button" type="submit">Log In</button>
            </div>
            <p class="forgot-password">
              <a href="/users/password/new">Forgot your Password?</a>
            </p>
          </fieldset>
        </form>
        <div class="second-half">
          <h3>Coming soon!</h3>
          <p>Soon, you'll be able to log in with Facebook...</p>
        </div>
      </div>
      <div class="call-to-action-button">
        <a href="/sign_up">New to Mysite? Sign up for an account to get goin'!</a>
      </div>
    </div>
    <footer>
      <div class="content"/>
    </footer>
  </body>
</html>
```

(imagine that pry has colorized this output, too, through the excellent CodeRay tool.)

I'd love to hear from you if you find this useful! Or even if you don't find it useful, but have some suggestions to improve it. Thanks!
