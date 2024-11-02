---
layout: post
title: Continuous Integration for the Lone Programmer
published: true
redirect_from:
  - /blog/2010/01/30/continuous-integration-for-the-lone-programmer/
---

(This post is part of my [blog archiving project](/about#old-posts). This post appeared on [blog.mattgauger.com](http://blog.mattgauger.com/2010/01/30/continuous-integration/) on January 30, 2010.)

There’s a laundry list of tools and practices in my head that I consider part of modern software engineering (version control, unit testing, code reviews, etc.) These aren’t necessarily required on every project. Continuous integration seems to be a practice that many prominent developers are using. But continuous integration servers aren’t very glamorous, and therefore don’t get a lot of discussion.

If you’re working alone on a project, committing it to version control, and using unit testing, what does it matter whether you run the tests yourself or have a continuous integration server running them? True, there’s a level of immediate feedback with running the tests yourself. But unless you’re building all the various unit testing and integration testing frameworks into one rake task, you may forget to run them all. In the case where you do have a rake task, your CI server could be running that for you on every commit. A continuous integration server ensures that the tests get run, whether you remember or not.

The other plus to this setup is that you can choose how and when the CI server interrupts you. You may be in a flow state and not want to be bothered by stopping to run the unit tests every five minutes when you know you’re not breaking them. That could be dangerous, though. If you zone out for a half day and come back to find all the tests failing, you’ll need to go back through the builds to see when and what commit first broke it. Luckily, the CI server should tell you that.

I set up [Integrity](http://integrityapp.com/) locally to run as my continuous integration system. Technically, Integrity could be hacked to build and test just about anything that gives a Unix return code, but I’m using it in its most common purpose: building Ruby projects that are hosted in [git](http://git-scm.org/) repos. While many developers are using [GitHub](http://github.com/), I’ve pointed Integrity at local git repos.

I did consider setting up a Campfire chat room to receive build status messages in, but it seemed overkill to sit alone in a chatroom to be updated by Integrity. So, I enabled the email functionality, and now Integrity is configured to email me with build status. If I keep a Firefox tab open to the Integrity server and choose whether to look at my email or not, I have a fairly effective barrier to decide when to let myself be interrupted. Meanwhile, the builds continue.

I’m hoping to optimize this and integrate it fully into my workflow, as TDD/BDD is a new thing to me and Integrity is already serving to reinforce writing good tests.
