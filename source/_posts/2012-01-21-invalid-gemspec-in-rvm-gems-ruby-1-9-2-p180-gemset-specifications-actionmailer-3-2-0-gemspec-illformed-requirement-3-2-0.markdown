---
layout: post
title: ! 'Invalid gemspec in [.rvm/gems/ruby-1.9.2-p180@gemset/specifications/actionmailer-3.2.0.gemspec]:
  Illformed requirement ["# 3.2.0"] '
published: true
redirect_from:
  - /blog/2012/01/21/invalid-gemspec-in-rvm-gems-ruby-1-9-2-p180-gemset-specifications-actionmailer-3-2-0-gemspec-illformed-requirement-3-2-0-/
  - /2012/01/21/invalid-gemspec-in-rvm-gems-ruby-1-9-2-p180-gemset-specifications-actionmailer-3-2-0-gemspec-illformed-requirement-3-2-0/
  - /blog/2012/01/21/invalid-gemspec-in-rvm-gems-ruby-1-9-2-p180-gemset-specifications-actionmailer-3-2-0-gemspec-illformed-requirement-3-2-0/
---
<p>Recently while trying to create a new Rails 3.2 project, I ran into this error after creating a new RVM gemset in Ruby 1.9.2-p180 and a Gemfile requiring only Rails 3.2.0:</p>
<div class="CodeRay">
  <div class="code"><pre>$ bundle
Fetching source index for http://rubygems.org/
Installing rake (0.9.2.2)
Installing i18n (0.6.0)
Installing multi_json (1.0.4)
Installing activesupport (3.2.0)
Installing builder (3.0.0)
Installing activemodel (3.2.0)
Invalid gemspec in [/Users/mathiasx/Developer/.rvm/gems/ruby-1.9.2-p180@big_fan/specifications/activemodel-3.2.0.gemspec]: Illformed requirement [&quot;# 3.2.0&quot;]
... These Illformed requirement errors continue for every package Rails wants ...</pre></div>
</div>

<p>I thought that I might be able to continue on and ignore these errors, but I hadn't seen anything like them anymore.</p>
<div class="CodeRay">
  <div class="code"><pre>$ rails new .
Invalid gemspec in [/Users/mathiasx/Developer/.rvm/gems/ruby-1.9.2-p180@big_fan/specifications/actionmailer-3.2.0.gemspec]: Illformed requirement [&quot;# 3.2.0&quot;]
... again, it throws this error many times ...</pre></div>
</div>

<p>That didn't generate a new Rails project in my current directory, so something was clearly wrong. But what does <strong>Illformed request: Syck:DefaultKey</strong> mean? Well, it turns out that the gemspecs of requirements in Rails 3.2.0 are using a new format that older Rubygems can't parse. The first indicator was that my version of Rubygems was out of date:</p>
<div class="CodeRay">
  <div class="code"><pre>$ gem -v
Invalid gemspec in [/Users/mathiasx/Developer/.rvm/gems/ruby-1.9.2-p180@big_fan/specifications/actionmailer-3.2.0.gemspec]: Illformed requirement [&quot;# 3.2.0&quot;]
... I've cut out a bunch of the output from the invalid gemspecs here ...
1.8.8</pre></div>
</div>

<p>We'd like to be on Rubygems 1.8.13 or newer, but I also don't want to see those invalid gemspec warnings anymore, so I clear out my gemset with:</p>
<div class="CodeRay">
  <div class="code"><pre>$ rvm gemset empty
WARN: Are you SURE you wish to remove the installed gemset for gemset 'ruby-1.9.2-p180@big_fan' (/Users/mathiasx/Developer/.rvm/gems/ruby-1.9.2-p180@big_fan)?
(anything other than 'yes' will cancel) &gt; yes
$ cd ..
$ cd project/
Using /Users/mathiasx/Developer/.rvm/gems/ruby-1.9.2-p180 with gemset big_fan</pre></div>
</div>

<p>Note that I have my rvmrc file like this so that it created and trusted the gemset upon encountering it:</p>
<div class="CodeRay">
  <div class="code"><pre>$ cat .rvmrc
rvm use 1.9.2@big_fan --create</pre></div>
</div>

<h2>Getting everything working again:</h2>
<p>Upgrade your Rubygems (this will only apply to this version of Ruby in RVM, not all versions of Ruby)</p>
<div class="CodeRay">
  <div class="code"><pre>$ gem update --system
== 1.8.15 / 2012-01-06

* 1 bug fix:

  * Don't eager load yaml, it creates a bad loop. Fixes #256


------------------------------------------------------------------------------

RubyGems installed the following executables:
        /Users/mathiasx/Developer/.rvm/rubies/ruby-1.9.2-p180/bin/gem

RubyGems system software updated</pre></div>
</div>

<p>Then just to be safe, make sure the gems we have are pristine (According to the manpage, gem pristine: "Restores installed gems to pristine condition from files located in the gem cache.")</p>
<div class="CodeRay">
  <div class="code"><pre>$ gem pristine --all</pre></div>
</div>

<p>And it is safe to now bundle:</p>
<div class="CodeRay">
  <div class="code"><pre>$ bundle
Fetching source index for http://rubygems.org/
Installing rake (0.9.2.2)
Installing i18n (0.6.0)
Installing multi_json (1.0.4)
Installing activesupport (3.2.0)
Installing builder (3.0.0)
Installing activemodel (3.2.0)
Installing erubis (2.7.0)
Installing journey (1.0.0)
Installing rack (1.4.0)
Installing rack-cache (1.1)
Installing rack-test (0.6.1)
Installing hike (1.2.1)
Installing tilt (1.3.3)
Installing sprockets (2.1.2)
Installing actionpack (3.2.0)
Installing mime-types (1.17.2)
Installing polyglot (0.3.3)
Installing treetop (1.4.10)
Installing mail (2.4.1)
Installing actionmailer (3.2.0)
Installing arel (3.0.0)
Installing tzinfo (0.3.31)
Installing activerecord (3.2.0)
Installing activeresource (3.2.0)
Using bundler (1.0.18)
Installing json (1.6.5) with native extensions
Installing rack-ssl (1.3.2)
Installing rdoc (3.12)
Installing thor (0.14.6)
Installing railties (3.2.0)
Installing rails (3.2.0)
Your bundle is complete! Use `bundle show [gemname]` to see where a bundled gem is installed.</pre></div>
</div>

<p>Now we should have a happy gemset and the error will be gone. Let me know if you have any questions. Happy hacking!</p>