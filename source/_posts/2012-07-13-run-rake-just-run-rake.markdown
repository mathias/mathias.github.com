---
layout: post
title: "Run rake. Just run rake."
date: 2012-07-13 14:59
comments: true
categories: 
---

Recently, I was setting up my laptop for an existing Rails project with the help of a pair. My pair was pivot on this project, which means that he'd been on it longer and so was bringing his experience and knowledge to the table, while I was seeing the project with fresh eyes.

"This is going to take forever to set up," he grumbled. "The documentation's out of date, and I remember there's a bunch of gotchas to setting this project up. We'll need to compile this, then do that, then you get an API key for.."

I went to Github and cloned the repo to my laptop.

"Just run rake," I replied.

"What?"

"Just run rake. It will tell us what to do next."

And indeed, it did tell us what to do. I've called this test-based configuration, or other funny things in the past, but you can just think of it as trying to get to a known good state - a state where all the tests run. If it prevents the tests from running, then it's the next thing you need.

I had to silence my pair's grumbling at this process, because at first it seems like you're going to be waiting a lot for rake, and that it might be easier just to remember all the steps necessary to set up a project.

In order, rake showed us all the steps we needed to do to get the project running. A full log of what this looks like setting up a simple Rails app can be seen [in this gist](https://gist.github.com/3112558).

### Why?

The point of software craftsmanship is to be pragmatic, not to seek perfection. I could have memorized the steps necessary to set up the average Rails project, but those steps wouldn't have applied here. And indeed, my pair could have memorized them, since he had been on the project. But those steps would go out the window as soon as my pair was on another project. It is far more pragmatic to know the behavior of our tools (like knowing that rake will tell us about each thing necessary to get to a state where the tests pass) and rely on that behavior rather than to seek perfection on this one project.

Note: we could have used our experience with Rails and software craftsmen to avoid some of the steps you see me running in the gist: for example, you probably know that if the databases aren't created, that you can run `rake db:create:all db:migrate db:test:prepare` all at once, without running rake inbetween every single rake task. That'd be far more pragmatic, as you're saving yourself time and effort by knowing the toolset. But I wanted to demonstrate that running rake between every single step told us what to do next. 

Now, ask yourself: How can you "just run rake" with your projects?
