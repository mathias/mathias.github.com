---
layout: post
title: "Creating an app dashboard with Hoplon"
date: 2014-03-17 08:02
---

Before we get into the other series of posts I'm working on, I thought I'd write a quick post on a new frontend framework that I'm really enjoying: [Hoplon](http://hoplon.io). You can go to their site to read up more on the concepts and how they work, but in a nutshell: Hoplon implements dataflow programming in ClojureScript. Another name for dataflow programming is "spreadsheet programming", because we use the abstraction of a "cell" that is either an input or a formula cell. Changes to input cells cause the formula cells be recomputed instantly &mdash; no manually calling your `render` function necessary!

Hoplon also works well with another tool from the same folks, called [Castra](https://github.com/tailrecursion/castra). Castra is basically an RPC framework that works well with Hoplon. Despite my initial negative reaction to the acronym RPC, I found that I enjoyed using Castra and together: they made for a very integrated app across clientside and serverside without worrying about JSON schemas, endpoint versioning, or any of that.

With these two tools together, one can quickly build a webapp where data changes on the backend, say, from an external API call, and is rendered on the frontend nearly instantaneously. (Depending on how you set up your code to fetch from the server, of course.)

This power made me think of a type of project that clients of every project seem to want lately: an app dashboard. App dashboards typically exist to show things like number of items in the worker queue, response times, analytics and A/B testing data, and raw numbers on counts of database tables, disk usage, etc. I have some experience building out these types of dashboards, as I'd built Bendyworks a dashboard called [loudspkr](https://github.com/mathias/loudspkr) to use as a team/social dashboard in the office. Loudspkr is based on Shopify's excellent [dashing](https://github.com/Shopify/dashing) framework. Dashing is very similar to Hoplon + Castra in functionality: it uses websockets to push data on channels to the frontend, and then uses [Batman.js](http://batmanjs.org/) to create data bindings to the DOM that are updated when data on those websocket channels changes.

So now that we've decided to build an app dashboard, let's take a look at our data. I have a small webapp that provides two JSON endpoints that look like this:

`GET /api/stats`

<script src="https://gist.github.com/mathias/9599072.js"></script>

`GET /api/health`

<script src="https://gist.github.com/mathias/9610523.js"></script>

And these are just some little endpoints that I'd added to a webapp that are only for authed admin and are meant to be used to keep an eye on things. Nothing really that special here, other than that we can depend on them to serve this data.

We start off by creating our project. You'll need boot, so follow the [installation instructions](https://github.com/tailrecursion/boot#getting-started) in their Getting Started guide.

First, create the project directory, cd into it and start tracking with git:

<script src="https://gist.github.com/mathias/9610932.js"></script>

Then run this to create a basic `build.boot` file:

<script src="https://gist.github.com/mathias/9610989.js"></script>

If you take a look at that file, you'll notice it is mostly empty. Boot scripts are like shell scripts; they set the interpreter env and then the rest of the file is in that language.

Since we want to use both Hoplon and Castra together, the quickest way to get started is to pattern our `build.boot` file after a project that is already set up to use those projects together. In the [hoplon-demos](https://github.com/tailrecursion/hoplon-demos/) repo on Github, there is a sample chat app that uses Hoplon and Castra. Take a look at its [build.boot](https://github.com/tailrecursion/hoplon-demos/blob/master/castra-chat/build.boot) file, and notice how it both sets up Hoplon compile task and a dev ring server task, then composes them together for the `chat-demo` task. I've taken that `build.boot` file and added in some deps inline, so that it looks like this:

