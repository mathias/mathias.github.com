---
layout: post
title: "Clojure Data Science: Sent Counts and Aggregates"
date: 2014-10-23 18:18
---

---

This is Part 3 of a series of blog posts called [Clojure Data Science](/categories/clojure-data-science). Check out the [previous post](blog/2014/04/13/clojure-data-science-refactoring-and-cleanup/) if you missed it.

---

For this post, we want to generate some summaries of our data by doing aggregate queries. We won't yet be pulling in tools like [Apache Storm](http://storm.incubator.apache.org/) into the mix, since we can accomplish this through Datomic queries. We will also talk about trade-offs of running aggregate queries on large datasets and devise a way to save our data back to Datomic.

## Updating dependencies

It has been some time since we worked on [autodjinn](https://github.com/mathias/autodjinn). Libraries move fast in the Clojure ecosystem, and we want to make sure that we're developing against the most recent versions of each dependency. Before we begin making changes, let's update everything. If you have already read my [Clojure Code Quality Tools](http://blog.mattgauger.com/blog/2015/09/15/clojure-code-quality-tools/) post, you'll be familiar with the `lein ancient` plugin.

Below is output when I run `lein ancient` on the last post's finished git tag, `v0.1.1`. To go back to that state, you can run `git checkout v0.1.1` on the [autodjinn repo](https://github.com/mathias/autodjinn).

<script src="https://gist.github.com/mathias/c349dc7cb110edb56235.js"></script>

It looks like our [nomad](https://github.com/james-henderson/nomad) dependency is out of date. Update the version number in `project.clj` to `0.7.0` and run `lein ancient` again to verify that it worked.

If you take a look at `project.clj` yourself, you may notice that our project is still on Clojure `1.5.1`. `lein ancient` doesn't look at the version of Clojure that we're specifying; it assumes you have a good reason for picking the Clojure version you specify. In our case, we'd like to be on the latest stable Clojure, version `1.6.0`. Update the version of Clojure in `project.clj` and then run your REPL. There should be no issues with using the functionality in the app that we created in previous posts. If there is, carefully read the error messages and try to find a solution before moving on.

To save on the hassle of upgrading, I have created a tag for the project after upgrading Clojure and nomad. To go to that tag in your local copy of the repo, run `git checkout v0.1.2`.

## Datomic query refresher

If you remember back to the [first post](blog/2014/03/30/clojure-data-science-ingesting-your-gmail-inbox/), we wrapped up by querying for entity IDs and then using Datomic's built-in `entity` and `touch` functions to instantiate each message with all of its attributes. We had to do this because the query itself only returned a set of entity IDs:

<script src="https://gist.github.com/mathias/ab5a827ca860c89e0043.js"></script>

Note that the Datomic query is made up of several parts:

* The `:find` clause says what will be returned. In this case, it is the `?eid` variable for each record we matched in the rest of the query.
* The `:where` clause gives a condition to match. In this case, we want all `?eid` where the entity has a `:mail/uid` fact, but we don't care about the `:mail/uid` fact's value, so we give it a wildcard with the underscore (`_`).

We could pass in the `:mail/uid` we care about, and only get one message's entity-ID back.

<script src="https://gist.github.com/mathias/4990c69f1e4c4a7dc7e9.js"></script>

Notice how the `?uid` variable gets passed in with the `:in` clause, as the third argument to `d/q`?

Or we could change the query to match on other attributes:

<script src="https://gist.github.com/mathias/3685937809a50e36c424.js"></script>

In all these cases, we'd still get the entity IDs back because the `:find` clause tells Datomic to return `?eid`. Typically, we pass around entity IDs and lazy-load any facts (attributes) that we need off that entity.

But, we could just as easily return other attributes from an entity as part of a query. Let's ask for the recipients of all the emails in our system:

<script src="https://gist.github.com/mathias/be2baf0af0b652966240.js"></script>

While it is less common to return only the value of an entity's attribute, being able to do so will allow us to build more functionality on top of our email abstraction later.

One last thing. Take a look at the return of that query above. Remember that the results returned by a Datomic query are a [set](http://clojure.github.io/clojure/clojure.core-api.html#clojure.core/set). In Clojure, sets are a collection of unique values. So we’re seeing the unique list of addresses that are in the To: field in our data. What we're not seeing is duplicate recipient addresses. To be able to count the number of times an email address received a message, we'll need a list with non-unique members.

Datomic creates a unique set for the values returned by a query. This is generally a great thing, since it gets around some of the issues that one can run into with JOINing in SQL. But in this case, it is not ideal for what we want to accomplish. We could try to get around the uniqueness constraint on output by returning vectors of the entity ID and the `?to` address, and then mapping across the result to pull out the second item:

<script src="https://gist.github.com/mathias/d6401a036d032caccde3.js"></script>

There's a simpler way that we can use in the Datomic query. By keeping it inside Datomic, we can later combine this approach with more-complex queries. We can tell the Datomic query to look at other attributes when considering what the unique key is by passing the query a `:with` clause. By changing our query slightly to include a `:with` clause, we end up with the full list of recipients in our datastore:

<script src="https://gist.github.com/mathias/f36ae56bef0e1b6cdfa9.js"></script>

At this point, it might be a good idea to review Datomic's [querying](http://docs.datomic.com/query.html) guide. We'll be using some of the advanced querying features found in the later sections of that guide, most notably aggregate functions.

## Sent Counts

For this feature, we want to find all the pairs of from-to addresses for each email in our datastore, and then sum up the counts for each pair. We will save all these sent counts into a new entity type in Datomic. This will allow us to ask Datomic questions like who sends you the most email, and who you send the most email to.

We start by building up the query in our REPL. Let's start with a simpler query, to count how many emails have been sent *to* each email address in our data store. Note that this isn't sufficient to answer the question above, since we won't know who those emails came *from*; they could have been sent by us or by someone else, or they could have been sent to us. Later, we'll make it work with from-to pairs that allow us to know things like who is sending email to us.

A simple way to do this would be to wrap our previous query in the [frequencies](http://clojure.github.io/clojure/clojure.core-api.html#clojure.core/frequencies) function that Clojure.core provides. `frequencies` returns a map of items with their count from a Clojure collection.

<script src="https://gist.github.com/mathias/af050f75d1c610d6d422.js"></script>

However, we want to perform the same sort of thing in Datomic itself. To do that, we're going to need to know about aggregate functions. Aggregate functions operate over the intermediate results of a Datomic query. Datomic provides functions like `max`, `min`, `sum`, `count`, `rand` (for getting a random value out of the query results), and more. With aggregates, we need to be sure to use a `:with` clause to ensure we aggregate over all our values.

Looking at that short list of aggregate functions I've named, we can see that we probably want to use the `count` function to count the occurance of each email address in a to field in our data. To see how aggregates work, I've come up with a simpler example (the only new thing to know is that Datomic's Datalog implementation can query across Clojure collections as easily as it can against a database value, so I've given a simple vector-of-vectors here to describe data in the form 

`[database-id person-name]`

When the query looks at records in the data, our `:where` clause gives each position in the vector an id and a name based on position in the vector.)

<script src="https://gist.github.com/mathias/6b8da156388ed1cd9290.js"></script>

Let's review what happened there. Before the `count` aggregate function was applied, our results looked like this:

`[["Jon"] ["Jon"] ["Bob"] ["Chris"]]`

So the `count` function just counts across the values of the variable it is passed (in our case, `?name`), and by pairing it with the original `?name` value, we get each name and the number of times it appears in our dataset.

It makes sense that we can do the same thing with our recipient email addresses from the previous query. Combining our previous queries with the `count` aggregate function, we get:

<script src="https://gist.github.com/mathias/8b346f1019d588bea534.js"></script>

That looks like the same kind of data we were getting with the use of the `frequencies` function before! So now we know how to use a Datomic aggregate function to count results in our queries.

What's next? Well, what we really want is to get results that are of the form 

`[from-address to-address]`

and count those tuples. That way, we can differentiate between email sent to us versus email we've sent to others, etc. And eventually, we'd like to save those queries off as functions that we can call to compute the counts from other places in our project.

We can't pass a tuple like `[from-address to-address]` to the `count` aggregate function in one query. The way around this is to write two queries. The inner query will return the tuples, and the outer query will return the tuple and a count of the tuple in the output data. Since the queries run on the peer, we don't really have to worry about whether it is one query or two, just that it returns the correct data at the end.

So what would the inner query look like? Remember that the outer query will still need a field to pass to the `:with` clause, so we'll probably want to pass through the entity ID. 

<script src="https://gist.github.com/mathias/61e60a563ffc29f06af8.js"></script>

Those tuples will be used by our outer query. However, we also need a combined value for the count to operate on. For that, we can throw in a function call in the `:where` clause and give it a binding at the end for Datomic to use for that new value. In this case, I'll combine the `?from` and `?to` values into a PersistentVector that the `count` aggregate function can use. The combined query ends up looking like this:

<script src="https://gist.github.com/mathias/d26c7175670b8c29e7c2.js"></script>

And the output is as we expect.

## Reusable functions

The next step is to turn the query above into various functions we can use to query for from-to counts later. In our data, we don't just have recipients in the To: field, we also have CC and BCC recipients. Those fields will need their own variations of the query function, but since they will share so much functionality, we will try to compose our functions in such a way that we avoid duplicate code.

In general, when I write query functions for Datomic, I use multiple arities to always allow a database value to be passed to the query function. This can be useful, for example, when we want to query against previous (historical) values of the database, or when we want to work with a particular database value across multiple queries, to ensure our data is consistent and doesn't change between queries.

Such a query function typically looks like this:

<script src="https://gist.github.com/mathias/f61fb370a3a2120daf6f.js"></script>

By taking advantage of multiple arities, we can default to not having to pass a database value into the function. But in the cases where we do need to ensure a particular database version is used, we can do that. This is a very powerful idiom that I've learned since I began to use Datomic, and I suggest you structure all your query functions similarly.

Now, let's take that function that only queries for `:mail/to` addresses and make it more generic, with specific wrapper functions for each case where we'd want to use it:

<script src="https://gist.github.com/mathias/67647105799f7f2ff1cf.js"></script>

Note that we had to change the inner query to take the attr we want to query on as a variable; this is the proper way to pass a piece of data into a query we want to run. The `$` that comes first in the `:in` clause tells Datomic to use the second `d/q` argument as our dataset (the db value we pass in), and the `?attr` tells it to bind the third `d/q` argument as the variable `?attr`.

While the three variations on functions are similar, we aren't reusing lots of code. In the long run, less code should mean less bugs and the ability to fix problems in one place.

Building complex systems by composing functions is one of the features of Clojure that I enjoy the most! And notice how we got to these finished query functions by building up functionality in our REPL: another aspect of writing systems in Clojure that I appreciate.

## Querying against large data sets

Right now, our functions calculate the sent counts across all messages every time they're called. This is fine for the small sample dataset I've been working with locally, but if it were to run against the 35K+ messages that are in my Gmail inbox alone (not to mention all the labels and other places my email lives&hellip;) it would take a very long time. With even bigger systems, we can run into an additional problem: the results may not fit into memory.

When building systems with datasets big enough that the intermediate or final results may not fit into memory, or that may take too much time to compute, there are two general approaches that we will explore. The first is storing results as data (known as memoizing or caching the results), and the other is breaking up the work to run on distributed systems like Hadoop or Apache Storm.

For this data, we only want to avoid redoing the calculating every time we want to know the sent counts. Currently, the data in our system changes infrequently, and it's likely that we could tell the system to recompute sent counts only after ingesting new data from Gmail. For these reasons, a reasonable solution will be to store the computed sent counts back into Datomic.

## A new entity type to store our results

For all three query functions we wrote, each result is of the form:

`[from-address to-address count]`

Let's add to the Datomic schema in our `core.clj` file to create a new `:sent-count` entity type with these three attributes. Note that sent counts don't really have a unique identifier of their own; it is the combination of `from` -> `to` addresses that uniquely identifies them. However, we will leave the `from` and `to` addresses as separate fields so it is easy to use them in queries.

Add the following maps to the `schema-txn` vector:

<script src="https://gist.github.com/mathias/661dadfdb2e639209452.js"></script>

You'll have to call the `update-schema` function in your REPL to run the schema transaction.

Something that's worth calling out is that we're using a Datomic schema `valueType` that we haven't seen yet in this project: `db.type/ref`. In most cases, you'd want to use the `ref` type to associate with other entities in Datomic. But we can also use it to associate with a given list of facts. Here, we give the `ref` type an enum of the possible values that `:sent-count/type` can have: `to`, `cc`, and `bcc`. By adding this `type` field to our new entities, we can either choose to look at sent counts for only one type of address, or we can sum up all the counts for a given from-to pair and get the total counts for the system.

Our next job is to add some functions to create the initial sent counts data, as well as to query for it. To keep things clean, I created a `sent-counts` namespace for these functions to live in. I've provided it below with minimal explanation, since it should look very familiar to what we've already done.

[/src/autodjinn/sent_counts.clj](https://github.com/mathias/autodjinn/blob/29cc08d1ead6043287ecb82136d3ee519668100f/src/autodjinn/sent_counts.clj)

After adding in the `sent_counts.clj` file, running:

`(sent-counts/create-sent-counts)`

will populate your datastore with the sent counts computed with functions we created earlier.

Note: The sent counts don't have any sort of unique key on them, so if you run `create-sent-counts` multiple times, you'll get duplicate results. We'll handle that another time when we need to update our data.

## Wrapping up

We've covered a lot of material on querying Datomic. In particular, we used aggregate functions to get the counts and sums of records in our data store. Because we don't want to run the queries all the time, we created a new entity type to store our sent counts and saved our data into it. With query functions like those found in the `sent-counts` namespace, we can start to ask our data questions like "In the dataset, what address was sent the most email?"

If you want to compare what you’ve done with my version, you can run `git diff v0.1.3` on the [autodjinn repo](https://github.com/mathias/autodjinn).

Please let me know what you think of these posts by sending me an email at [contact@mattgauger.com](mailto:contact@mattgauger.com). I’d love to hear from you!
