---
layout: post
title: "Find naughty naughty model calls in your views"
date: 2013-01-24 11:32
---

---

*(This post is part of my blog archiving project. This post appeared on [Coderwall](https://coderwall.com/p/33siha) on January 24, 2013.)*

---

I found this really helpful in a project where almost all the views were requesting things from the database rather than letting the controller handle it.

I've got a couple little regexes with various levels of specificity to help you seek and destroy!

In vim with Fugitive, run:

    :Ggrep "(<%|=|-).*[A-Z].*\.(find|order|where|includes|all)" app/views/

This will find places where someone is using model classes with queries in your views. This should work for both erb and haml views. You'll probably get a few false matches (I eliminated the common ones like capitalized link titles in a link_to call, for example), but overall I was able to reduce a ton of naughty code.

If you want to catch other annoying things (like using Time.now calls), you can look for what should be classes used in views:

    :Ggrep "(<%|=|-).*[A-Z].*\." app/views

If you want to be even simpler, you could just look for those ActiveRelation queries:

    :Ggrep "(find|order|where|includes|all)" app/views/

These also both work from the command line (if you don't have Fugitive in your vim yet) by replacing :Ggrep with git-grep:

    git-grep "(find|order|where|includes|all)" app/views/

With these tools in your belt, you can find all those calls to the database in your views and improve your Rails app.

Let me know if this tip was helpful at @mathiasx on Twitter!
