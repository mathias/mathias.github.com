---
layout: post
title: "Creating an app dashboard with Hoplon"
date: 2014-03-17 08:02
---

Before we get into the other series of posts I'm working on, I thought I'd write a quick post on a new front end framework that I'm enjoying: [Hoplon](http://hoplon.io). You can go to their site to read up more on the concepts and how they work, but in a nutshell: Hoplon implements dataflow programming in ClojureScript. Another name for dataflow programming is "spreadsheet programming", because we use the abstraction of a "cell" that is either an input or a formula cell. Changes to input cells cause the formula cells be recomputed instantly &mdash; no manually calling your `render` function necessary!

Hoplon also works well with another tool from the same folks, called [Castra](https://github.com/tailrecursion/castra). Castra is basically an RPC framework that works well with Hoplon. Despite my initial negative reaction to the acronym RPC, I found that I enjoyed using Castra. Combining Castra with Hoplon makes for an integrated app across the client and server side. All this without worrying about JSON schemas, endpoint versioning, or any of that.

With these two tools together, one can quickly build a web app where data changes on the backend, say, from an external API call, and is rendered on the frontend as a result. (Depending on how you set up your code to fetch from the server, of course.)

This power made me think of a type of project that every client seems to want lately: an app dashboard. App dashboards exist to show things like number of items in the worker queue, response times, and analytics data. They're also employed to show raw numbers on counts of database tables, disk usage, etc. There's more advanced things that one can show, of course, but that's beyond the scope of this post.

I have some experience building these types of dashboards: I’ve built an app called [loudspkr](https://github.com/mathias/loudspkr) to use as a team/social dashboard in our office. I based loudspkr on Shopify's excellent [dashing](https://github.com/Shopify/dashing) framework. Dashing is similar to Hoplon + Castra in functionality: it uses websockets to push data on channels to the frontend, and then uses [Batman.js](http://batmanjs.org/) to create data bindings to the DOM. Those bindings are updated when data on those websocket channels changes.

So, I thought it'd be a good idea to build an app dashboard with Hoplon and Castra. This blog post will follow the development and point out some important bits. But note that this post is by no means an exhaustive tutorial for Hoplon, Castra, or any of the other tools presented.

Now that we've decided to build an app dashboard, let's take a look at our data. I have a small webapp that provides two JSON endpoints that look like this:

`GET /api/stats`

<script src="https://gist.github.com/mathias/9599072.js"></script>

`GET /api/health`

<script src="https://gist.github.com/mathias/9610523.js"></script>

These are just some little endpoints that I'd added to a webapp that admin can use to keep an eye on things. Nothing that special here, other than that we can depend on them to serve this data and they are rather simple.

We start off by creating our project. You'll need boot, so follow the [installation instructions](https://github.com/tailrecursion/boot#getting-started) in their Getting Started guide.

Since there isn’t a Leiningen template yet for Hoplon + Castra, setting everything up takes a little bit of work. To save you some time, I've pushed the code for this post to [mathias/gleam](https://github.com/mathias/gleam). You can clone it and check out this commit to get back to the beginning to follow along:

<script src="https://gist.github.com/mathias/9611242.js"></script>

We now should have a basic `build.boot` with tasks for starting up our Hoplon compilation, our Castra Ring server, and running them both (with `boot gleam-app`). Test that everything is correct by running `boot gleam-app`. After some compile steps, you should see a timer start counting up from the last time it compiled. You should keep this terminal running and open a new one for the rest of the post. We want Hoplon to continue compiling and our server to continue serving requests.

## Creating the dashboard on the clientside

Next up, we want to create the Hoplon component of our dashboard. Hoplon has two syntaxes: one that looks more like Lisp, and one that looks more like HTML with special syntax for interpolating our dynamic Hoplon data. We'll be using the HTML syntax because it should be the most familiar, but I recommend eventually learning the HLisp syntax.

Create a file in `src/hoplon/index.html.hl` and insert the following:

<script src="https://gist.github.com/mathias/9611321.js"></script>

If you load up `http://localhost:8000` and you are still running the `boot gleam-app` task in your other terminal, you should see an empty page with the title "Gleam". But, the important part is that the page is served and you're not seeing errors in the terminal or your browser!

Next, we want to experiment with getting data rendered into our view. Let's create some cells of data up in the script tag at the top to store the kind of data we know our endpoint is going to return:

<script src="https://gist.github.com/mathias/9611621.js"></script>

We store a ClojureScript map of the data so that we can pull it out later in the same structure that we know our JSON API will give it to us. This is how we interpolate the values into our HTML:

<script src="https://gist.github.com/mathias/9611626.js"></script>

You may have noticed that as you edited `index.html.hl` and saved it, the browser updated automatically, without having to reload. This is caused by the line `(reload-all)` in the Hoplon script at the top of our file. This is a nice feature to have in place for development.

At this point, you should have a page that looks like this:

<img src="/images/gleam-basic.png" alt="gleam screenshot" style="display: block;margin: 0 auto;">

Let's stop to think about what we did. We `def`d some values in the script above, which are basically *cells*, and we were able to interpolate that value into the HTML here.

What if we wanted to output some data that wasn't a static value? For example, if our API didn't return the total number of articles, how would we sum up that value to display?

That might look something like this:

<script src="https://gist.github.com/mathias/9611732.js"></script>

And we would use our new formula cell in the HTML like this:

<script src="https://gist.github.com/mathias/9611740.js"></script>

As you can see, it's easy to add computed values to the frontend with Hoplon, and have them automatically get rendered along with other values.

Ultimately, we're not going to need to compute that value. So let's undo that change and start looking at how to get data from a ClojureScript file.

You'll notice that inside `/src` is a `cljs` directory, which contains a `gleam` directory. This directory holds ClojureScript namespaces for our app, such as what we'll use to talk to our Castra server. For now, let's move our stub data over to a ClojureScript file named `rpc.cljs`.

In `src/cljs/gleam/rpc.cljs`:

<script src="https://gist.github.com/mathias/9635157.js"></script>

In `src/hoplon/index.html.hl`:

<script src="https://gist.github.com/mathias/9635166.js"></script>

Check your page -- everything should still be working. If you would like, you can `git reset --hard d63f299` to get to this state in the repo I provided.

## Talking to the server

In this past step, all we did was push the definition of the data into our ClojureScript file. Now we can start trying to get that data from the backend.

The first step is to, again, move our data to another namespace. This time, though, the data is going to live on the server. To set that up, we'll need a couple pieces of code in place.

The file `src/castra/gleam/core.clj` which sets up the Castra server itself that our frontend code will talk to:

<script src="https://gist.github.com/mathias/9635301.js"></script>

You might need to restart your `boot gleam-app` command after this step, since we need it to pick up this new server and run it.

Next up, we create a file that will contain functions that the clientside can call.

In `src/castra/gleam/api/gleam.clj`:

---


# SCRATCH

First, create the project directory, cd into it and start tracking with git:

<script src="https://gist.github.com/mathias/9610932.js"></script>

Then run this to create a basic `build.boot` file:

<script src="https://gist.github.com/mathias/9610989.js"></script>

If you take a look at that file, you'll notice it is mostly empty. Boot scripts are like shell scripts; they set the interpreter env and then the rest of the file is in that language.

Since we want to use both Hoplon and Castra together, the quickest way to get started is to pattern our `build.boot` file after a project that is already set up to use those projects together. In the [hoplon-demos](https://github.com/tailrecursion/hoplon-demos/) repo on Github, there is a sample chat app that uses Hoplon and Castra. Take a look at its [build.boot](https://github.com/tailrecursion/hoplon-demos/blob/master/castra-chat/build.boot) file, and notice how it both sets up Hoplon compile task and a dev ring server task, then composes them together for the `chat-demo` task. I've taken that `build.boot` file and added in some deps inline, so that it looks like this:

