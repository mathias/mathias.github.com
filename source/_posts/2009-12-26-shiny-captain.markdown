---
layout: post
title: Shiny, Captain!
published: true
redirect_from:
  - /blog/2009/12/26/shiny-captain-/
  - /blog/2009/12/26/shiny-captain/
---

(This post is part of my [blog archiving project](/about#old-posts). This post appeared on [blog.mattgauger.com](http://blog.mattgauger.com/2009/12/26/shiny-captain/) on December 29, 2009.)

Today I decided I wanted to start blogging again. I thought about my options on my hosting, and didn’t particularly feel like running a full-blown blog engine like Wordpress or Drupal. I knew I wanted a nice custom theme but I didn’t want to waste time trying to wrap my head around another theming engine.

In the very far past, I had a blog run on a friend’s server that was generated as static html files (and an RSS feed) by a perl script. It’s still available on [archive.org](http://web.archive.org/web/*/http://tranzor.net/~xiphias). There are several Ruby-based projects that do the same thing. I chose [Jekyll](http://github.com/mojombo/jekyll/), which is what [Github Pages](http://pages.github.com/) runs on. I grabbed the gem off the Github gem server and set up the basic directory structure. The whole setup is extremely simple:

```
.
|-- _config.yml
|-- _layouts
|   |-- default.html
|   `-- post.html
|-- _posts
|   `-- 2009-12-26-shiny-captain.md
|-- _site
`-- index.html
```

After creating those files, I was off and running with creating a theme from scratch. I’ve had my eye on HTML5 for awhile, and recently read an [article on Smashing Mag](http://www.smashingmagazine.com/2009/08/04/designing-a-html-5-layout-from-scratch/) that inspired me. I used their method of defining the HTML5 tags as blocks in CSS to allow me to write HTML5 now and render it in today’s browsers.

After a few hours, while my girlfriend watched Law & Order SVU on Netflix next to me, I coded up the theme for this blog. I stole the template for the [Atom feed](http://blog.mattgauger.com/atom.xml) from [mbleigh](http://github.com/mbleigh/mbleigh.github.com/blob/master/atom.xml). There’s still plenty of room for tweaks and improvements I want to make. But I’m trying not to be a perfectionist, and instead follow the maxim of _release early, release often_.

Below is the “Hello World” post I whipped up initially to help with theming:

* * *

This is the first post!

> this is a block quote!

This isn’t a block quote!

This is some Ruby:

{% highlight ruby %}
(Hpricot(open url)/:enclosure).map {|x| x.attributes["url"]}.uniq.each do |vid|
  # File.exist?(vid.split("/").last) ? next : `curl #{vid}`
  filename = vid.gsub(/http:.+\//, '')
  filename.gsub!(/-/, "_")
  next if File.exist?(filename)

  puts "Downloading #{vid}"
  puts filename
  `curl -L #{vid} > #{filename}`
{% endhighlight %}
