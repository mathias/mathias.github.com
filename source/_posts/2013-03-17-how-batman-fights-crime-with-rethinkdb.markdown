---
layout: post
title: "How Batman Fights Crime with RethinkDB"
date: 2013-03-17 14:52
comments: true
---

Recently, I need a document store for a project. (It most certainly doesn't have relational data, so let's not go there, ok?) There's a couple different data sources, and the schema (that is, attributes on the JSON data being imported) should be allowed to change without requiring massive data migrations in the future.

Further, the data should grow fairly linearly. Basically, imagine the system will continue to receive inserts for a long time to build up a dataset, on top of which I'd like to start writing some analytics code. That said, the idea of having to scale and properly configure a MongoDB cluster that would eventually grow to need more than one EC2 extra-large instance didn't just sound frustrating, it sounded expensive. I've talked to engineers about the issues of scaling MongoDB, properly picking a shard key, etc. and that didn't seem to be something I even wanted to worry about. Further, I don't have thousands of dollars per month to throw at hosting this project.

So after a bit of searching for a document store that didn't focus as much on in-memory as it did on scaling on cheap disks, I found [RethinkDB](http://www.rethinkdb.com/). RethinkDB is an open source project backed by a for-profit startup. But from all indications on its Github page, it has a healthy community growing around it.

RethinkDB is neat in that it has a very simple, and very SQL-like, interface language. For more on how RethinkDB is different and whether it is a good fit for what you're doing, see their [FAQ](http://www.rethinkdb.com/docs/faq/) and their post on the [differences of RethinkDB versus other NoSQL solutions](http://www.rethinkdb.com/blog/mongodb-biased-comparison/).

First we set up our server by running it where we want the data to live. In
this case, I have a directory named `sandbox` that I want my rethinkdb data to
live in:

<script src="https://gist.github.com/mathias/f4e8c6ca7a9542fc73b2.js"></script>

The data will now live in `sandbox/rethinkdb_data`. This is important to know if you're used to servers like Postgres putting the data somewhere in `/var/` for you. You can certainly do that, it just needs to be configured.

When we go to the admin panel (by default at `localhost:8080`) we will see that the
database is up and healthy. Go into the Data Explorer tab:

![Data Explorer tab](/images/data_explorer_tab.png)

From here, we can build queries in the JavaScript adapter and run them against
our database.

So let's assume we're Batman. Our job is to maintain a [Batputer](http://en.wikipedia.org/wiki/Batcomputer)
which tracks all criminals and crimes that Batman is investigating in his role as the world's greatest detective.

First, we create our Batputer database:

<script src="https://gist.github.com/mathias/15143b9006ce58c79816.js"></script>

***Note that in previous versions of the Data Explorer, you had to append the `.run()`
function onto queries in the Data Explorer, but in 1.4.0 that is no longer necessary.***

You'll see in the tabs below the input box that we get back a JSON response,
and if you click the 'Table View' tab, you'll see we also get a table
representation &mdash; this will be more important later when we are
retrieving data from the database.

![Data Explorer response](/images/dbcreate_batputer.png)

