---
layout: post
title: The First 2500 Are the Hardest
published: true
redirect_from:
  - /blog/2009/12/27/the-first-2500-are-the-hardest/
---

(This post is part of my blog archiving project. This post appeared on [blog.mattgauger.com](http://blog.mattgauger.com/2009/12/27/the-first-2500-are-the-hardest/) on December 27, 2009.)

Seth Godin is a prolific blogger. He’s also a successful author. When he hit his [3000th post](http://sethgodin.typepad.com/seths_blog/2009/02/luckiest-guy.html), I remember him writing

> The hard part, as you can guess, is the first 2,500 posts. After that, momentum really starts to build.

Of course, I just started this blog. This is post number 3\. And I’ve never really been able to develop a blogging habit. But maybe this time it’ll stick.

Onto the continuing adventures of tweaking this blog theme:

I was in the backseat of my parent’s van after to go to a family holiday get-together.

I had my laptop, and a vague problem of the nav buttons at the top right of the blog being fully rounded in Google Chrome on my macmini. But Firefox showed the nav buttons the way I wanted, with only the two lower corners rounded and a nice squarish block right up to the top brown border line. Luckily, I also had my awesome girlfriend with me. The offending piece of CSS looked like this:

{% highlight css %}
border-radius: 5px;

border-bottom-right-radius: 5px;
-moz-border-radius-bottomright: 5px;
-webkit-border-bottom-right-radius: 5px;

border-bottom-left-radius: 5px;
-moz-border-radius-bottomleft: 5px;
-webkit-border-bottom-left-radius: 5px;
{% endhighlight %}

She pointed out that I was using the generic CSS method of rounding the corners, **border-radius**, but also using the Mozilla (Firefox) and Webkit (Safari) specific methods as well for the lower corners. So, I commented out that bit about the **border-radius** and waited, as we were barreling down the highway at 60 MPH in the backseat of a van, and for some reason the Department of Transportation hasn’t started installing free wireless access points on the highway. Which limits my ability to update my blog from the road. Luckily, I don’t find myself in the backseats of vans on the highway very often. (City buses are a different story.) So I uploaded the changes when I got home and tested it. **Success!**

Now to move onto some minor [jQuery](http://jquery.com/) effects I want to implement. Nothing flashy, just the Javascript equivalent of hover effects, I’m thinking.
