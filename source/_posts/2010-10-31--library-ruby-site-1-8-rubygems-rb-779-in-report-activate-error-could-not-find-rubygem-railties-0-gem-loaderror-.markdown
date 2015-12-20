---
layout: post
title: ! '/Library/Ruby/Site/1.8/rubygems.rb:779:in `report_activate_error'': Could
  not find RubyGem railties (>= 0) (Gem::LoadError) '
published: true
redirect_from:
  - /blog/2010/10/31/-library-ruby-site-1-8-rubygems-rb-779-in-report-activate-error-could-not-find-rubygem-railties-0-gem-loaderror-/
  - /2010/10/31/-library-ruby-site-1-8-rubygems-rb-779-in-report-activate-error-could-not-find-rubygem-railties-0-gem-loaderror-/
  - /blog/2010/10/31/-library-ruby-site-1-8-rubygems-rb-779-in-report-activate-error-could-not-find-rubygem-railties-0-gem-loaderror/
---

<p>I tend to blog things that I want to remember, but couldn't find in one quick Google search.</p>
<p>This is an error I got while starting the <a href="http://railstutorial.org/book">Rails Tutorial</a>, because I was using an old system (I counted about 160 gems installed) and starting to use <a href="http://rvm.beginrescueend.com/">rvm</a> for managing my Ruby installs, because the Rails Tutorial recommends it. I haven't had this kind of issue before, because rails, gem, and ruby commands have all just worked out-of-the-box for me since Mac OS X 10.5 was released.</p>
<p>When I tried to create a new Rails app, I got the error in the title of the blog post:</p>
<div class="CodeRay">
  <div class="code"><pre>minimite:railstutorial.org mathiasx$ rails new first_app
/Library/Ruby/Site/1.8/rubygems.rb:779:in `report_activate_error': Could not find RubyGem railties (&gt;= 0) (Gem::LoadError)
        from /Library/Ruby/Site/1.8/rubygems.rb:214:in `activate'
        from /Library/Ruby/Site/1.8/rubygems.rb:1082:in `gem'
        from /usr/bin/rails:18
minimite:railstutorial.org mathiasx$ rails -v
/Library/Ruby/Site/1.8/rubygems.rb:779:in `report_activate_error': Could not find RubyGem railties (&gt;= 0) (Gem::LoadError)
        from /Library/Ruby/Site/1.8/rubygems.rb:214:in `activate'
        from /Library/Ruby/Site/1.8/rubygems.rb:1082:in `gem'
        from /usr/bin/rails:18</pre></div>
</div>

<p>That didn't make sense. Where is the Rails command being run from?</p>
<div class="CodeRay">
  <div class="code"><pre>minimite:railstutorial.org mathiasx$ which ruby
/Users/mathiasx/.rvm/rubies/ruby-1.9.2-p0/bin/ruby
minimite:railstutorial.org mathiasx$ which gem
/Users/mathiasx/.rvm/rubies/ruby-1.9.2-p0/bin/gem
minimite:railstutorial.org mathiasx$ which rails
/usr/bin/rails</pre></div>
</div>

<p>Aha. Obviously the previously-installed Rails gem, from before installing rvm, was an issue. So I figured I'd just clean it up.</p>
<div class="CodeRay">
  <div class="code"><pre>minimite:railstutorial.org mathiasx$ rvm list

rvm rubies

   ruby-1.8.7-p302 [ i386 ]
=&gt; ruby-1.9.2-p0 [ i386 ]

minimite:railstutorial.org mathiasx$ rvm use 1.8.7
Using /Users/mathiasx/.rvm/gems/ruby-1.8.7-p302
minimite:railstutorial.org mathiasx$ sudo gem uninstall rails
Remove executables:
        rails

in addition to the gem? [Yn]  y
Removing rails
Successfully uninstalled rails-3.0.1
minimite:railstutorial.org mathiasx$ which rails
/usr/bin/rails</pre></div>
</div>

<p>But I hadn't been paying attention. I still had not removed the Rails executable, because I was calling the rvm version of Ruby 1.8.7 and not the system-level one. Knowing that Rails was in /usr/bin/rails, I assumed that the gem executable that managed it would also be in /usr/bin:</p>
<div class="CodeRay">
  <div class="code"><pre>minimite:railstutorial.org mathiasx$ sudo /usr/bin/gem uninstall rails
Remove executables:
        rails

in addition to the gem? [Yn]  y
Removing rails

You have requested to uninstall the gem:
        rails-3.0.0
clearance-0.9.0.rc9 depends on [rails (~&gt; 3.0.0)]
factory_girl_rails-1.0 depends on [rails (&gt;= 3.0.0.beta4)]
suspenders-0.1.0.beta.4 depends on [rails (&gt;= 3.0.0)]
If you remove this gems, one or more dependencies will not be met.
Continue with Uninstall? [Yn]  y
Successfully uninstalled rails-3.0.0</pre></div>
</div>

<p>I'd finally removed the system-level Rails script and can switch back to using rvm for everything:</p>
<div class="CodeRay">
  <div class="code"><pre>minimite:railstutorial.org mathiasx$ rvm use 1.9.2
Using /Users/mathiasx/.rvm/gems/ruby-1.9.2-p0
minimite:railstutorial.org mathiasx$ which rails
/Users/mathiasx/.rvm/gems/ruby-1.9.2-p0/bin/rails
Using /Users/mathiasx/.rvm/gems/ruby-1.9.2-p0
minimite:railstutorial.org mathiasx$ rails new first_app
      create
      &lt;-- Lots of output --&gt;</pre></div>
</div>

<p>It works!</p>
<p><strong>Lesson learned:</strong> Always pay attention. The answer is probably sitting right in front of you.</p>
