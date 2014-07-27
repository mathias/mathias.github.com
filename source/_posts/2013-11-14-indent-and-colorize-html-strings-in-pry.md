---
layout: post
title: "Indent and colorize HTML strings in pry"
date: 2013-11-14 11:32
---

---

*(This post is part of my blog archiving project. This post appeared on [Coderwall](https://coderwall.com/p/hlbana) on November 14, 2013.)*

*Note: I have converted the inline code to Gists for better readabililty.*

---

An issue I run into frequently while testing with tools like [capybara](https://github.com/jnicklas/capybara) by dropping into [pry](http://pryrepl.org/) is that the last response for a page is a single string, containing the HTML that was rendered. But those string have lost indentation and generally make it really hard to see the content of the page, or whatever you care about.

For example, a simple login page might look like:

<script src="https://gist.github.com/mathias/2007dab63a9fe77d7182.js"></script>

Wouldn't it be great if Pry could re-indent and colorize that string of HTML for you? Well, I put together a quick little Pry command that does. Throw this into your `~/.pryrc`:

<script src="https://gist.github.com/mathias/21a971d0bdb3620a8909.js"></script>

Originally, I had tried to use the html5 fork of the `tidy` command: [https://github.com/w3c/tidy-html5](https://github.com/w3c/tidy-html5) but that tool *changes* the HTML as it parses it, and spits out a bunch of warnings. So instead, I have this pry command use `nokogiri` when it is available. The command should warn you if you try to use it without `nokogiri` available. What is output should be very close to the original rendered HTML, just cleaned up and re-indented. 

So what does it look like in action?

<script src="https://gist.github.com/mathias/4065f861db4cd9e280ad.js"></script>

(imagine that pry has colorized this output, too, through the excellent CodeRay tool.)

I'd love to hear from you if you find this useful! Or even if you don't find it useful, but have some suggestions to improve it. Thanks!
