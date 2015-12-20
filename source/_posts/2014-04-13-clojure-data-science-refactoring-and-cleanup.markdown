---
layout: post
title: "Clojure Data Science: Refactoring and Cleanup"
date: 2014-04-13 16:28
redirect_from:
  - /blog/2014/04/13/clojure-data-science-refactoring-and-cleanup/
---

---

This is Part 2 of a series of blog posts called [Clojure Data Science](/blog/categories/clojure-data-science). Check out the [previous post](/blog/2014/03/30/clojure-data-science-ingesting-your-gmail-inbox/) if you missed it.

---

Welcome to the second post in this series. If you followed along in the last post, your code should be ready to use in this post. If not, or if you need to go back to known working state, you can clone the [autodjinn repo](https://github.com/mathias/autodjinn) and `git checkout v0.1.0`.

I started out writing this post to develop simple functionality on our inbox data. Finishing the post was taking longer than I was expecting, so I split the post in half in the interest of posting this sooner.

In this post, we need to create an email ingestion script that we can run repeatedly with `lein`. And we need to talk about refactoring our code out into maintainable namespaces.

So make sure your Datomic transactor is running and launch a REPL, because it is time to give our code a makeover.

## A Gmail ingestion script

Because Clojure sits on the JVM, it shares some similarities with Java. One of these is the special purpose of a `-main` function. You can think of this as the `main` method in a Java class. The `-main` function in a Clojure namespace will be run when a tool like `lein` tries to "run" the namespace. That sounds like exactly what we want to do with our Gmail import functionality, so we will add a `-main` function that calls our `ingest-inbox` function. To get started, we will only have it print us a message.

<script src="https://gist.github.com/mathias/9965864.js"></script>

You can then run this by invoking `lein run -m autodjinn.core`. You should see `Hello world!` if everything worked. You may notice that the process doesn't seem to quit after it prints the hello world message -- this seems to be problem with Leiningen. To ensure that our process ends when the script is done, we can add a `(System/exit 0)` line to the end of our `-main` function to ensure that the process quits normally. On *nix systems, a 0 return code means successful exit, and a nonzero response code means something went wrong. Knowing this, we can take advantage of response codes in the future to signal that an error occurred in our script. But for now, we will have the script end by returning 0 to indicate a successful exit.

Think back to what we did to ingest email in our REPL in the last post. We had to connect to the database, run the data schema transaction, and then we were able to run `ingest-inbox` to pull in our email.

The following function will do the same thing. Remember that things like trying to create an existing database or performing a schema update against the same schema in Datomic should be harmless. It will add a new transaction ID, but it will not modify or destroy data. Putting together all the steps we need to run, we get a `-main` function that looks like this:

<script src="https://gist.github.com/mathias/9965933.js"></script>

## Refactoring namespaces

With Clojure, one must walk a fine line between putting all of your functions into one big file, and having too many namespaces. One big file quickly grows unmaintainable and gains too many responsibilities.

But having too many namespaces can also be a problem. It may create strange cyclic dependency errors. Or you may find that with many separate namespaces, you have to require many namespaces to get anything done.

To avoid this, I start with most code in one namespace, and then look for common functionality to extract to a new namespace. Good candidates to extract are those that all talk about the same business logic or business domain. You may notice that the responsibility for one group of functions is different than the rest of the functions. That is a good candidate for a new namespace. Looking at responsibilities can be a good way to determine where to break apart functions into namespaces.

In this project, we can identify two responsibilities that currently live in our autodjinn.core namespace. The first is working with the database. The second is ingesting Gmail messages. As our project grows, we will not want the code for ingesting Gmail messages to live in `autodjinn.core`. With that in mind, let's create a new file called `src/autodjinn/gmail_ingestion.clj` and move over the vars and functions that we think should live there. That file should look like this:

<script src="https://gist.github.com/mathias/9966207.js"></script>

Be sure to remove the functions and vars that we moved to this file from the `autodjinn.core` namespace. Note that we moved the `-main` function here, too, so that we can now run `lein run -m autodjinn.gmail-ingestion`

You may also notice that we still had to require the `datomic.api` namespace here to be able to perform a transaction. Our `autodjinn.core` namespace already handles database interaction, though. So let's write a `create-mail` function in `core.clj` and call it in our new namespace:

<script src="https://gist.github.com/mathias/9966294.js"></script>

And in `gmail_ingestion.clj` we change `ingest-inbox` to use the new function. While we're at it, we'll break out a convenience function to prepare the attr map for Datomic:

<script src="https://gist.github.com/mathias/9966304.js"></script>

If we run our `lein run -m autodjinn.gmail-ingestion` command, we should see that the code is still working.

Don't forget to remove the `datomic.api` requirement in `gmail-ingestion` namespace! Now we only need to require Datomic in the `autodjinn.core` namespace.

There's one more low-hanging fruit that we can refactor about this code before moving on. The config file is loaded and used in both namespaces. We already require everything from `autodjinn.core` into `autodjinn.gmail-ingestion`. So we can safely change a few lines to use the config in `gmail_ingestion.clj` and stop requiring `nomad` in two places:

<script src="https://gist.github.com/mathias/9966372.js"></script>

And in `core.clj`:

<script src="https://gist.github.com/mathias/9966384.js"></script>

Running `lein run -m autodjinn.gmail-ingestion` one more time, we should see that our changes did not break the system. The config is now only loaded once, and we use it everywhere.

That's it! We've taken care of some low-hanging fruit and are ready to implement some new functionality. If you want to compare what you've done with my version, you can run `git diff v0.1.1` on the [autodjinn repo](https://github.com/mathias/autodjinn).

Please let me know what you think of these posts by sending me an email at [contact@mattgauger.com](mailto:contact@mattgauger.com). I'd love to hear from you!
