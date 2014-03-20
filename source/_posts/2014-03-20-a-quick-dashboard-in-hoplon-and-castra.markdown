---
layout: post
title: "A quick dashboard in Hoplon &amp; Castra"
date: 2014-03-20 13:29
---

*Note:* I began writing a much longer blog post that went into a ton of detail about how to build an app dashboard that used Hoplon and Castra. The kind of dashboard that just consumes JSON API endpoints from another app or other data sources. Such dashboards update on the fly in the browser. Many apps these days need a dashboard like this to monitor stats: worker job queues, database size, average response times, etc.

Rather than that long blog post, I wanted to simply show the steps I would take to build such a dashboard with [Hoplon](http://hoplon.io) and [Castra](https://github.com/tailrecursion/castra). I won't go into detail here or explain either Hoplon or Castra &mdash; go read on your own first, and also look into [boot](https://github.com/tailrecusion/boot), the build tool this uses.

If you want to follow along, I've provided a [repo](https://github.com/mathias/gleam). The [README](https://github.com/mathias/gleam/blob/30b4976b313c950c6cc97e64c65036eb21d75378/README.md) has instructions for getting setup. Assuming you have boot installed, you can just run `boot gleam-app` to get started.

So here's how I'd build up a dashboard, in several iterations:

## Static data in the browser:

First, we get some data into the HTML using Hoplon cells:

<script src="https://gist.github.com/mathias/9670739.js"></script>

You'll want to `git reset --hard 69b070` to get to this point.

## Move the data to ClojureScript:

In `src/cljs/gleam/rpc.cljs`:

<script src="https://gist.github.com/mathias/9635157.js"></script>

And take out the `(def articles…)` from `index.html.hl`. After boot recompiles everything, you should still see the data in the page.

To get to this point, you can run `git reset --hard d63f299`.

## Move the data to the server side

Change `src/cljs/gleam/rpc.cljs` again, this time to make a remote call for data:

<script src="https://gist.github.com/mathias/9671172.js"></script>

On the backend, we need something like this in `src/castra/gleam/api/gleam.clj`:

<script src="https://gist.github.com/mathias/9671200.js"></script>

The Hoplon HTML file changes in the script tag at the top to use the new ClojureScript remote call and start up the polling:

<script src="https://gist.github.com/mathias/9671220.js"></script>

To get to this point in the example repo, you can do `git reset --hard 0bad1e5`.

## Real time data

The last step that I will show is to verify that we are in fact getting regular updates of data from the back end.

Change your Castra Clojure file to look like this:

<script src="https://gist.github.com/mathias/9671661.js"></script>

To get to this point, you can do a `git reset --hard f19325`

## Talking to a remote service.

The last step here is left as an exercise for the reader. You can imagine replacing the `articles function in `src/castra/gleam/api/gleam.clj` with something that polls a remote JSON API for data. Or you could look at my social news app [gnar](http://github.com/mathias/gnar) for inspiration on using a Postgres database for data.

I hope to finish up a post with full explanations soon. Castra is relatively new, and it's worth explaining how some of the pieces fit together. My explanation should include more complicated interaction. like user authentication. I will be publishing that blog post after I get back from [ClojureWest](http://clojurewest.org) next week!

Let me know what you thought of this post by shooting me an [email](mailto:contact@mattgauger.com). I'd love to hear from you.
