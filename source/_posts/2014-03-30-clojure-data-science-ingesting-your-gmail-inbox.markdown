---
layout: post
title: "Clojure Data Science: Ingesting Your Gmail Inbox"
date: 2014-03-30 14:44
redirect_from:
  - /blog/2014/03/30/clojure-data-science-ingesting-your-gmail-inbox/
---

---

This is Part 1 of a series of blog posts inspired by the exercises from [Agile Data Science](http://shop.oreilly.com/product/0636920025054.do) with Clojure. You may be interested in my [review]({% post_url 2014-03-14-agile-data-science-review-and-thoughts %}) of the book.

---

For this blog post series, we are going to use your Gmail inbox as a dataset for an exploration of data science practices. Namely, we will use your email for machine learning and natural language processing applications. Email makes interesting data to process:

* it has lots of metadata that we can use as features <a href="#cds-gmail-footnote-1" name="cds-gmail-footnote-1-return">[1]</a>
* we can model the relationships of senders and receivers as a graph
* each message has a body of text associated with it that we can analyze
* gaining insights from our personal communication is far more interesting than using an open data set!

**Note:** This is not an intro-to-Clojure blog post. If you need a tutorial that starts with the basics, I recommend the [Clojure from the ground up](http://aphyr.com/tags/Clojure-from-the-ground-up) blog post series by [Aphyr](https://twitter.com/aphyr). It does an excellent job at introducing concepts in Clojure.

In this post, I follow my typical Clojure workflow: I open a REPL and begin exploring the problem space. I look at individual pieces of data and start transforming them. When I write some functionality that I like for one piece of data, I try to extract it into the source code as a function that can work for any data our project may see. In this way, we can build up the project to contain the functions that are necessary to get to our goal.

So what is our goal for this blog post? Well, we want to fetch all emails from our Gmail inbox. We want to get metadata for each email, including things like who sent it and when it was sent. Then, we want to save the messages into a database so we can do further processing in later posts.

Starting off, make a new basic Clojure project with lein. I've named my project [autodjinn](https://github.com/mathias/autodjinn) after [AUTODIN](http://en.wikipedia.org/wiki/Email#Origin), one of the first email networks. You can use the [repo](https://github.com/mathias/autodjinn) to refer to and to clone to follow along. At the beginning of each subsequent post, I'll provide a SHA that you can reset the code to. Feel free to name your project whatever you want; just be sure to pay attention to the changes in filenames and namespaces as we go along!

Create the project and enter it:

```shell
lein new autodjinn

cd autodjinn
```

To import our Gmail data, we will use a Clojure library called [clojure-mail](https://github.com/owainlewis/clojure-mail). Clojure-mail is still under active development and is likely to change. For this blog post, we'll be using version `0.1.6` to ensure compatibility between the code in this post and the library.

Edit `project.clj` to contain your information and add the `[clojure-mail "0.1.6"]` dependency:

```clojure
(defproject autodjinn "0.1.0-SNAPSHOT"
  :description "An email analysis tool"
  :url "CHANGEME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.5.1"]
                 [clojure-mail "0.1.6"]])
```

We'll start by working in `src/autodjinn/core.clj` and later move the functionality out into a script for our email import task. Open up the file in your favorite editor and launch a REPL.

In your REPL, `(use 'autodjinn.core)` and verify it worked by running `(foo "MYNAME")`. You should see "MYNAME Hello, World!" printed out. Feel free to remove the `(defn foo…)` in `core.clj` now. We will not need it.

You may want to use something like Emacs' [cider](https://github.com/clojure-emacs/cider) or LightTable's InstaREPL as your REPL environment. But you can use the regular Clojure REPL to build this project, as well. If you are not working with a REPL integrated to your editor, you will need to run `(use 'autodjinn.core :reload)` to force a reload of the code each time you save.

## Connecting to Gmail

Our first goal is to connect to our inbox and verify that we can read email from it. To do that, we're going to need to use our Gmail address and password &mdash; which we don't want to put into our source files. **It's bad practice to put a password or a private key into a source file or check it into our repo! Just don't do it!**

Instead, we will use a nice library called [nomad](https://github.com/james-henderson/nomad) to load a config file containing our email address and password. We will add the config file to `.gitignore` so that it is never saved into our code.

Add the line `[jarohen/nomad "0.6.3"]` to your `project.clj` dependencies before moving on, and run `lein deps` in a console to pull in the dependency.

Back in our `core.clj` add the require statements for `clojure-mail` and `nomad` to your ns macro like this:

```clojure
(ns autodjinn.core
  (require [clojure-mail.core :refer all]
           [clojure-mail.message :as message]
           [nomad :refer [defconfig]]]))
```

Then create a new file in `resources/config/autodjinn-config.edn`. It should look like this, with your email address and password filled in:

```clojure
{:gmail-username "you@gmail.com"
 :gmail-password "yourpassword"}
```

Now open up your `.gitignore` file and add the following line to it:

```shell
resources/config/*-config.edn
```

Following [nomad's README](https://github.com/james-henderson/nomad#hello-world), we need to load our config file and pull out our `gmail-username` and `gmail-password` keys. We add to the following to `core.clj` after the `ns` macro:

```clojure
;; in autodjinn/core.clj:
(defconfig autodjinn-config (io/resource "config/autodjinn-config.edn"))

(def gmail-username (get (autodjinn-config) :gmail-username))
(def gmail-password (get (autodjinn-config) :gmail-password))

;; Note that we must call autodjinn-config as a function
;; to use it as a map!
```

Using the `get` function here is a safe lookup for maps that returns `nil` if nothing is found for the key. Back in our REPL, we can see this in action with some quick experimentation:

```clojure
user=> (def mymap {:a "b"})
;=> #'user/mymap
user=> (get mymap :a)
;=> "b"
user=> (get mymap :c)
;=> nil
```

We could also use the shorter `(:keyname mymap)` syntax here, since symbols are an invocable function that looks up a key in a map. But the `get` function reads better than `(:gmail-username (autodjinn-config))` in my opinion.

In your REPL, you should now be able to get the values for `gmail-username` and `gmail-password`:

```clojure
user> autodjinn.core/gmail-username
;=> "myname@gmail.com"
user> autodjinn.core/gmail-password
;=> "mypassword"
```

Note that since I'm in the `user` namespace here, I had to qualify the vars with their `autodjinn.core` namespace. If this is confusing, you might want to read up on [namespaces in Clojure](http://clojure-doc.org/articles/language/namespaces.html) before moving on. (See also: the 'Namespaces' section in [Clojure from the ground up: logistics](http://aphyr.com/posts/311-clojure-from-the-ground-up-logistics).)

`clojure-mail` requires us to open a connection to Gmail with the `gen-store` function ([src](https://github.com/owainlewis/clojure-mail/blob/c3aad67b42aad96405d4c329ca48e29b7960d412/src/clojure_mail/core.clj#L80-L83)). We then pass that connection around to various functions to interact with our inbox. Define a var called `my-store` in your `core.clj` that does this with our email address and password:

```clojure
;; in core.clj after defining gmail-username and gmail-password:
(def my-store (gen-store gmail-username gmail-password))
```

Make sure the `(def my-store…` above has been run in your REPL and then take a look at our open connection:

```clojure
user> autodjinn.core/my-store
;=> #<IMAPSSLStore imaps://myname%gmail.com@imap.gmail.com>
```

The type of `my-store` should be an `IMAPSSLStore` as above. If it didn't work, you'll see a string error message when you try to define `my-store`.

## Your inbox as a list

Now we'll use our REPL to build up a function that will eventually import all of our email. To start, we can use the `inbox` function ([src](https://github.com/owainlewis/clojure-mail/blob/c3aad67b42aad96405d4c329ca48e29b7960d412/src/clojure_mail/core.clj#L198-L201)) from `clojure-mail` to get a seq of messages in our inbox. Note that since it is a seq and inboxes can be very large, we limit it with the `take` function.

```clojure
user> (use 'clojure-mail.core)
;=> nil
user> (take 4 (inbox autodjinn.core/my-store))
;=> (#<IMAPMessage com.sun.mail.imap.IMAPMessage@676ef6f3> #<IMAPMessage com.sun.mail.imap.IMAPMessage@26170092> #<IMAPMessage com.sun.mail.imap.IMAPMessage@302684c7> #<IMAPMessage com.sun.mail.imap.IMAPMessage@30d73d83>)
```

If everything is working, you should see a list of of the `IMAPMessage`s returned by the last line in your REPL.

What if, instead, we wanted to loop over many messages and print out their subjects? We can pull in the `message` namespace ([src](https://github.com/owainlewis/clojure-mail/blob/master/src/clojure_mail/message.clj)) from `clojure-mail`, which gives us convenience functions for getting at message data.

You'll have to be careful running this next line &mdash; on a large inbox it'll print out the subject of everything in your inbox! If you have a lot of messages, consider wrapping the call to `inbox` in a `take` as above.

```clojure
user> (require '[clojure-mail.message :as message])
;=> nil
user> (doseq [msg (inbox autodjinn.core/my-store)]
  (println (message/subject msg)))
Subject 3
Testing!
Subject 2
Subject 1
;=> nil

;; With a limit on the number of subjects to print:
user> (doseq [msg (take 2 (inbox autodjinn.core/my-store))]
  (println (message/subject msg)))
Subject 3
Testing!
nil
```

Those are the subject lines of the 4 messages in the inbox of my test account, so I know that this is working. Save our `doseq` line into a function called `ingest-inbox`; we'll come back to it later. In `core.clj`:

```clojure
(defn ingest-inbox []
  (doseq [msg (inbox autodjinn.core/my-store)]
    (println (message/subject msg))))
```

## Examining messages

Before we move on, let's take a look at an individual message and what we can get out of it from the `message` namespace.

```clojure
user> (first (inbox autodjinn.core/my-store))
;=> #<IMAPMessage com.sun.mail.imap.IMAPMessage@71999260>
user> (def my-msg (first (inbox autodjinn.core/my-store)))
;=> #'user/my-msg
user> (message/subject my-msg)
;=> "Subject 3"
user> (message/id my-msg)
;=> "<CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com>"
user> (message/from my-msg)
;=> "Matt Gauger <contact@mattgauger.com>"
user> (message/to my-msg)
;=> ("contact@mattgauger.com")
;; note that this is a seq!

user> (message/message-body my-msg)
;=> ({:content-type "TEXT/PLAIN; charset=ISO-8859-1", :body "Body\r\n"} {:content-type "TEXT/HTML; charset=ISO-8859-1", :body "<div dir=\"ltr\">Body</div>\r\n"})
```

From this, we can see a few things:

* The ID returned by `message/id` looks like a good candidate to get good unique IDs for each message when we store the messages. But we might want to strip off those angle brackets first.
* The `message/message-body` function doesn't return a string of the body. Instead, it returns a list of maps which contains the `text/plain` form of the body and the `text/html` form. We will have to extract each from the map so that we can use the plaintext version for things like language processing. We'll also keep the HTML version in case we need it later.
* If you started digging in to the `message` namespace's source you may have noticed that we don't have functions for getting date sent or date received for a message. Nor can we get a list of addresses CCed or BCCed for the message. We'll have to write those functions ourselves.

## Cleaning up the IDs

Let's focus on writing a function to clean up the ID returned by the `message/id` function. Recall that such IDs look like `<CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com>`

The `clojure.string` namespace provides a `replace` function which does simple replacement on a string. We can use it like this:

```clojure
user> (def my-id (message/id my-msg))
;=> #'user/my-id
user> my-id
;=> "<CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com>"
user> (clojure.string/replace my-id ">" "")
;=> "<CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com"
user> (clojure.string/replace my-id "<" "")
;=> "CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com>"
```

That worked for replacing the angle brackets for the original string. But remember that data structures are immutable in Clojure, including strings. Replacing the first angle bracket didn't change the original string when we tried to replace the other angle bracket. We need something that allows us to build up an intermediate value and pass it to the next function. For that, we will use the [thread-first](http://clojure.github.io/clojure/clojure.core-api.html#clojure.core/-%3e) macro: `->`. It is easiest if I show the macro in use with some comments showing what the intermediate values would be at each step:

```clojure
(-> my-id ;; "<CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com>"
    (clojure.string/replace ">" "")  ;; "<CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com"
    (clojure.string/replace "<" "")) ;; "CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com"
;=> "CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com"
```

It is called the **thread-first** macro because it threads through the first argument to each function. In this case, `clojure.string/replace`'s first argument is the string to replace on. So the each successively returned value gets passed to the next function above.

Now that we've figured out how to clean up that ID, we will create a function to clean up any ID we pass it. In `core.clj`:

```clojure
(defn remove-angle-brackets [string]
  (-> string
      (clojure.string/replace ">" "")
      (clojure.string/replace "<" "")))
```


## Extracting the message bodies

Recall the `message/message-body` call above:

```clojure
user> (message/message-body my-msg)
;=> ({:content-type "TEXT/PLAIN; charset=ISO-8859-1", :body "Body\r\n"} {:content-type "TEXT/HTML; charset=ISO-8859-1", :body "<div dir=\"ltr\">Body</div>\r\n"})
```

Ideally, we want to write a function that can get the `text/plain` body out of this value, and another function that can get the `text/html` body out. Notice that the `:content-type` values aren't quite so simple as just selecting the item in the list where the string `text/plain` appears. We will need our function to ignore the additional information in the `:content-type` value, which includes things like string encodings.

Let's look at just the first map in the list returned by `message/message-body`:

```clojure
user> (def my-bodies (message/message-body my-msg))
;=>#'user/my-bodies
user> (first my-bodies)
;=> {:content-type "TEXT/PLAIN; charset=ISO-8859-1", :body "Body\r\n"}
user> (:content-type (first my-bodies))
;=> "TEXT/PLAIN; charset=ISO-8859-1"
```

If we build a predicate function that can detect when the `:content-type` key is the type we want, we can use it in a `filter` function to choose the correct type of body in our functions.

Notice that `TEXT/PLAIN` and `TEXT/HTML` are always separated from the rest of the content-type by a semicolon, and it always appears first. You'd have to look at a few messages from your inbox to arrive at the same conclusion, but I've already done the work and can assure you that the previous statement is true.

Then, an easy to to get at the part of the content-type we want would be to split on the semicolon and take the first element returned:

```clojure
user> (:content-type (first my-bodies))
;=> "TEXT/PLAIN; charset=ISO-8859-1"
user> (clojure.string/split (:content-type (first my-bodies)) #"[;]")
;=> ["TEXT/PLAIN" " charset=ISO-8859-1"]
user> (first (clojure.string/split (:content-type (first my-bodies)) #"[;]"))
;=> "TEXT/PLAIN"
user> (clojure.string/lower-case (first (clojure.string/split (:content-type (first my-bodies)) #"[;]")))
;=> "text/plain"

;; of course, we can use the thread-first macro again
;; to stop building up nested calls

user> (-> my-bodies
          (first)
          (:content-type)
          (clojure.string/split #"[;]")
          (first)
          (clojure.string/lower-case))
;=> "text/plain"
```

This leads us to a function to first clean up the content-type string, and then our predicate function to detect if it is the one we want. In `core.clj`:

```clojure
(defn simple-content-type [full-content-type]
  (-> full-content-type
      (clojure.string/split #"[;]")
      (first)
      (clojure.string/lower-case)))

(defn is-content-type? [body requested-type]
  (= (simple-content-type (:content-type body))
     requested-type))
```

To finish off our work on the message bodies, we want to filter the list returned by `message/message-body`:

```clojure
user> (filter #(is-content-type? %1 "text/plain") my-bodies)
;=> ({:content-type "TEXT/PLAIN; charset=ISO-8859-1", :body "Body\r\n"})
user> (first (filter #(is-content-type? %1 "text/plain") my-bodies))
;=> {:content-type "TEXT/PLAIN; charset=ISO-8859-1", :body "Body\r\n"}
user> (:body (first (filter #(is-content-type? %1 "text/plain") my-bodies)))
;=> "Body\r\n"
```

And turn it into a function that works for any message bodies list. In `core.clj`:

```clojure
(defn find-body-of-type [bodies type]
  (:body (first (filter #(is-content-type? %1 type) bodies))))

(defn get-text-body [msg]
  (find-body-of-type (message/message-body msg) "text/plain"))

(defn get-html-body [msg]
  (find-body-of-type (message/message-body msg) "text/html"))
```

Note that we've also used this function to create two convenience functions, one for extracting plaintext bodies and one for extracting HTML bodies. By keeping functions simple and small, we can build up useful functions for our project rather than try to plan it all out ahead of time.

## Getting more information out of the IMAPMessages

As noted above, we will need to write a few more functions to get the fields of the `IMAPMessage`s that we cannot get through this version of `clojure-mail`. Recall that we want to get CC list, BCC list, date sent, and date received values. To do that, we will use Java interop functionality. It's really not as bad as it sounds. Remember that the `IMAPMessage`s we see are Java instances of the `IMAPMessage` class. Calling a method on an instance is accomplished by using a dot before the method name, with the method in the function position, such as: `(.javaMethod some-java-instance)`

To start, we can look at `clojure-mail`'s [project.clj](https://github.com/owainlewis/clojure-mail/blob/c3aad67b42aad96405d4c329ca48e29b7960d412/project.clj) and see that it depends on `javax.mail`. The next step is to find the documentation for the Java implementation of `javax.mail.Message`, which [lives here](http://docs.oracle.com/javaee/6/api/javax/mail/Message.html).

In the REPL, we can try some of the Java interop on our `my-msg`:

```clojure
user> my-msg
;=> #<IMAPMessage com.sun.mail.imap.IMAPMessage@eeb0450>
user> (.getSentDate my-msg)
;=> #inst "2014-03-28T16:35:22.000-00:00"
user> (.getReceivedDate my-msg)
;=> #inst "2014-03-28T16:35:42.000-00:00"
```

The datetimes for each message are automatically converted from Java `Date`s into Clojure instants (timestamps) for us, which is convenient. If we dig into how the `clojure-mail.message/to` function [[src](https://github.com/owainlewis/clojure-mail/blob/c3aad67b42aad96405d4c329ca48e29b7960d412/src/clojure_mail/message.clj#L16-L20)] works, we see that it is using the `.getRecipients` method. `.getRecipients` takes the message and a constant of a `RecipientType`. For our purposes, we want the `javax.mail.Message$RecipientType/CC` and `javax.mail.Message$RecipientType/BCC` recipients:

```clojure
user> (.getRecipients my-msg javax.mail.Message$RecipientType/CC)
;=> #<InternetAddress[] [Ljavax.mail.internet.InternetAddress;@f9d085d>
user> (.getRecipients my-msg javax.mail.Message$RecipientType/BCC)
;=> nil
user> (map str (.getRecipients my-msg javax.mail.Message$RecipientType/CC))
;=> ("matt@bendyworks.com")
```

The last line maps the `str` function across each element returned, so that we get the string representation of the email addresses. That way, our database can just store the strings.

As before, now that we know how to use these methods in the REPL, we write functions in `core.clj` to take advantage of our newfound knowledge:

```clojure
(defn get-sent-date
  "Returns an instant for the date sent"
  [msg]
  (.getSentDate msg))

(defn get-received-date
  "Returns an instant for the date sent"
  [msg]
  (.getReceivedDate msg))

(defn cc-list
  "Returns a sequence of CC-ed recipients"
  [msg]
  (map str
    (.getRecipients msg javax.mail.Message$RecipientType/CC)))

(defn bcc-list
  "Returns a sequence of BCC-ed recipients"
  [msg]
  (map str
    (.getRecipients msg javax.mail.Message$RecipientType/BCC)))
```

In the REPL, it should now be possible to get a nice map representation of all the fields on the message we care about:

```clojure
user> my-msg
;=> #<IMAPMessage com.sun.mail.imap.IMAPMessage@eeb0450>
user> {:mail/uid (remove-angle-brackets (message/id my-msg))
 :mail/from (message/from my-msg)
 :mail/to (message/to my-msg)
 :mail/cc (cc-list my-msg)
 :mail/bcc (bcc-list my-msg)
 :mail/subject (message/subject my-msg)
 :mail/date-sent (get-sent-date my-msg)
 :mail/date-received (get-received-date my-msg)
 :mail/text-body (get-text-body my-msg)
 :mail/html-body (get-html-body my-msg)}
;=> {:mail/cc ("matt@bendyworks.com"), :mail/from "Matt Gauger <contact@mattgauger.com>", :mail/date-sent #inst "2014-03-28T16:35:22.000-00:00", :mail/uid "CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com", :mail/to ("contact@mattgauger.com"), :mail/html-body "<div dir=\"ltr\">Body</div>\r\n", :mail/subject "With Matt@Bendyworks in CC", :mail/date-received #inst "2014-03-28T16:35:42.000-00:00", :mail/bcc (), :mail/text-body "Body\r\n"}
user> (clojure.pprint/pprint *1)
{:mail/cc ("matt@bendyworks.com"),
 :mail/from "Matt Gauger <contact@mattgauger.com>",
 :mail/date-sent #inst "2014-03-28T16:35:22.000-00:00",
 :mail/uid
 "CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com",
 :mail/to ("contact@mattgauger.com"),
 :mail/html-body "<div dir=\"ltr\">Body</div>\r\n",
 :mail/subject "Testing 3",
 :mail/date-received #inst "2014-03-28T16:35:42.000-00:00",
 :mail/bcc (),
 :mail/text-body "Body\r\n"}
;=> nil
```


Congratulations on making it this far. We've used quite a few neat little features of Clojure and the libraries we're building this project with to get here.

The last step we'll go through in this post is to get these messages into a database.

## Enter Datomic, the immutable datastore

[Datomic](http://www.datomic.com/) is a great database layer built on Clojure that gives us a database value representing immutable data. New transactions on the database create new database values. It fits very well with Clojure's own concept of [state and identity](http://clojure.org/state) because it was designed by the same folks as Clojure. Plus, Datomic is meant to grow and scale in modern environments like AWS, with many backend datastore options to run it on.

There's some important reasons why you might choose Datomic as your database for a data science / machine learning application:

* There are various storage backends, so you can grow from tens of thousands of rows in PostgreSQL on a developer's laptop to millions of records (or more) in Riak or DynamoDB on AWS. That is, it has a good migration path from small datasets to big data through the Datomic import/export process
* The concept of time associated with each value in Datomic means that we can query for historical data to compare against
* Datomic has a lightweight schema compared to a relational database like PostgreSQL. Schemas are just data! When we begin computing new values from our dataset, we can add new types of entities easily at the same time.
* Datomic's schemas allow us to treat it as a key-value store, relational database, or even build a graph store on top of it, if we need to

**Note**: I won't go through setting up an entire Datomic installation here. It's worth reading up on the [docs](http://docs.datomic.com/) and the [rationale](http://www.datomic.com/rationale.html) behind Datomic's design.

You can get the [Datomic free build](https://my.datomic.com/downloads/free) if you like, but you will be limited to in-memory stores. It is unlikely that your Gmail inbox will fit into memory on your dev machine. Instead, I recommend signing up for the free [Datomic Pro Starter Edition](http://www.datomic.com/get-datomic.html). (The free Starter Edition is fine because you will not be using this project in a commercial capacity.) Once you have Datomic Pro downloaded and installed in your local Maven, I recommend using the PostgreSQL storage adapter locally with memcached. Follow the guides for configuring storage on the [Datomic Storage](http://docs.datomic.com/storage.html) page.

Add the correct line to your `project.clj` dependencies for the version of Datomic you'll be using (mine was `[com.datomic/datomic-pro "0.9.4384"]` which might be a bit out of date and likely won't match yours.) Now we can start using Datomic in our `core.clj` and our REPL.

The first thing we need is the URI where the Datomic database lives. When we start up the Datomic transactor, you will see a DB URI that looks something like `datomic:sql://DBNAMEHERE?jdbc:postgresql://localhost:5432/datomic?user=datomic&password=datomic` in the output. Grab that URI and add it to our `resources/config/autodjinn-config.edn`:

```clojure
{:gmail-username "you@gmail.com"
 :gmail-password "yourpassword"
 :db-uri "datomic:sql://DBNAMEHERE?jdbc:postgresql://localhost:5432/datomic?user=datomic&password=datomic"}
```

Back at the top of `core.clj`, save that value to a var as we did with `gmail-username` and `gmail-password`:

```clojure
(def db-uri (get (mail-config) :db-uri))
```

And then in the REPL:

```clojure
user> (require '[datomic.api :as d])
;=> nil
user> (d/create-database db-uri)
;=> true
user> (d/create-database db-uri)
;=> false
user> (def db-connection (d/connect db-uri))
;=> #'user/db-connection
user> (d/db db-connection)
;=> datomic.db.Db@8472447a
```

Note that according to the [datomic clojure docs for the create-database function](http://docs.datomic.com/clojure/index.html#datomic.api/create-database), it returns true if the database was created, and false if it already exists. So running `create-database` every time we run our script is safe, since it won't destroy data.

If the above work in the REPL doesn't work, it is likely your code is unable to talk to your running Datomic, or your Datomic transactor is not configured correctly. Diagnose it with Googling and reading the docs until you get it to work, then move on.

Calling `(d/db db-connection)` gives us the current value of our database. In most cases, we want to just get the most current value. So, we can write a convenience function `new-db-val` to always get us the current (and possibly different) database value. But there are cases where we want to coordinate several queries and use the same database values for each. In those cases, we won't use the function get the latest database value, but rather pass this database value to the queries so that all query against the same state.

In our `core.clj`, we can add the code we need to create the database, get our connection, and the convenience `new-db-val` function:

```clojure
;; Always try to create the database
(d/create-database db-uri)

(def db-connection (d/connect db-uri))

(defn new-db-val [] (d/db db-connection))
```

Next, we need to tell Datomic about the schema of our data. Schemas are just data that you run as a transaction on the database. Reading up on the [Schema](http://docs.datomic.com/schema.html) page of the Datomic docs might be helpful to understand what's going on here. The short version is that we define each attribute of an email and set up its properties. The collection of all attributes together will constitute a `mail` entity, so we namespace all the attributes under the `:mail/` namespace.

```clojure
(def schema-txn
  [{:db/id #db/id[:db.part/db]
    :db/ident :mail/uid
    :db/valueType :db.type/string
    :db/cardinality :db.cardinality/one
    :db/unique :db.unique/identity
    :db/index true
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/to
    :db/valueType :db.type/string
    :db/cardinality :db.cardinality/many
    :db/fulltext true
    :db/index true
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/cc
    :db/valueType :db.type/string
    :db/cardinality :db.cardinality/many
    :db/fulltext true
    :db/index true
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/bcc
    :db/valueType :db.type/string
    :db/cardinality :db.cardinality/many
    :db/fulltext true
    :db/index true
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/from
    :db/valueType :db.type/string
    :db/cardinality :db.cardinality/one
    :db/fulltext true
    :db/index true
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/subject
    :db/valueType :db.type/string
    :db/cardinality :db.cardinality/one
    :db/fulltext true
    :db/index true
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/date-sent
    :db/valueType :db.type/instant
    :db/cardinality :db.cardinality/one
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/date-received
    :db/valueType :db.type/instant
    :db/cardinality :db.cardinality/one
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/text-body
    :db/valueType :db.type/string
    :db/fulltext true
    :db/index true
    :db/cardinality :db.cardinality/one
    :db.install/_attribute :db.part/db}
   {:db/id #db/id[:db.part/db]
    :db/ident :mail/html-body
    :db/valueType :db.type/string
    :db/cardinality :db.cardinality/one
    :db.install/_attribute :db.part/db}])
```

We add that var def to our `core.clj` because it is, after all, just data. We may choose later to move it to its own `edn` file, but for now, it can live in our source code. Next, we want to apply this schema to our database with a transaction. That looks like this:

```clojure
user> schema-txn
;=> [{:db/cardinality :db.cardinality/one, …}]
user> (d/transact db-connection schema-txn)
;=> #<promise$settable_future$reify__4427@5ede7c85: {:db-before datomic.db.Db@8472447a, :db-after datomic.db.Db@f8962e84, :tx-data [#Datum{:e 13194139534322 :a 50 :v #inst "2014-03-30T20:37:53.113-00:00" :tx 13194139534322 :added true} #Datum{:e 77 :a 41 :v 36 :tx 13194139534322 :added true} #Datum{:e 77 :a 44 :v true :tx 13194139534322 :added true} #Datum{:e 77 :a 51 :v true :tx 13194139534322 :added true} #Datum{:e 77 :a 40 :v 23 :tx 13194139534322 :added true} #Datum{:e 77 :a 10 :v :mail/bcc :tx 13194139534322 :added true} #Datum{:e 0 :a 13 :v 77 :tx 13194139534322 :added true}], :tempids {-9223367638809264705 64, -9223367638809264706 73, -9223367638809264707 77, -9223367638809264708 65, -9223367638809264709 66, -9223367638809264710 67, -9223367638809264711 68, -9223367638809264712 69, -9223367638809264713 70, -9223367638809264704 63}}>
```

Now we put that transaction in a convenience function in `core.clj` that we'll run every time we run this file. The function will ensure that our database is 'converged' to this schema. Running a transaction will create a new database value. But it will not blow away any data that we had in the database by running this transaction many times. It will simply try to update the existing attributes, and nothing in the attributes themselves need change. It is far more work to retract (delete) data in Datomic than it is to add or update it. This leads to much more safety around working with data without worrying that we will destroy data, and it encourages a REPL-based exploration of the data and its history.

```clojure
(defn update-schema []
  (d/transact db-connection schema-txn))
```

Now that our `mail` entities are defined in Datomic, we can try a query to find all the entity-IDs where any `:mail/uid` value is present. Read up on the [Query](http://docs.datomic.com/query.html) page of the Datomic docs to dig into querying deeper. You might also be interested in the excellent [Learn Datalog Today](http://www.learndatalogtoday.org/) website to learn more about querying Datomic with Datalog.

```clojure
user> (d/q '[:find ?eid :where [?eid :mail/uid _]] (new-db-val))
;=> #{}
```

Since we have no `mail` entities in our database, Datomic returns an empty set. So now we reach the end of task: We can ingest some emails and save them in our database! Return to the `ingest-inbox` function that we left before. Here's what the updated version will look like:

```clojure
(defn ingest-inbox []
  (doseq [msg (inbox my-store)]
    (println (message/subject msg))
    @(d/transact db-connection [{:db/id (d/tempid "db.part/user")
                                 :mail/uid (remove-angle-brackets (message/id msg))
                                 :mail/from (message/from msg)
                                 :mail/to (message/to msg)
                                 :mail/cc (cc-list msg)
                                 :mail/bcc (bcc-list msg)
                                 :mail/subject (message/subject msg)
                                 :mail/date-sent (get-sent-date msg)
                                 :mail/date-received (get-received-date msg)
                                 :mail/text-body (get-text-body msg)
                                 :mail/html-body (get-html-body msg)}])))
```

We use the `@`-sign before the `(d/transact…)` call because Datomic normally returns a promise of the completed transaction. However, we want to force Datomic to complete each transaction before moving on by deref-ing it with the `@`-sign. Per the Clojure docs: "Calls to deref/@ prior to delivery will block."

If you run this function in your REPL, you should see it start to ingest your email from Gmail!

```clojure
user> (autodjinn.core/ingest-inbox)
Subject 3
Testing!
Subject 2
Subject 1
;=> nil
user> (d/q '[:find ?eid :where [?eid :mail/uid _]] (new-db-val))
;=> #{[17592186045419] [17592186045421] [17592186045423] [17592186045425]}
```

Note that this could a take a **long time** if you've chosen to import a really large Gmail inbox! You might want to stop the import at some point; in most REPLs `Ctrl-c` will stop the running function.

If we query for our entity-IDs again, as above, we should see some values returned!

What does one of those database entities look like when we run it through Datomic's [entity](http://docs.datomic.com/clojure/index.html#datomic.api/entity) and [touch](http://docs.datomic.com/clojure/index.html#datomic.api/touch) functions to instantiate all its attributes?

```clojure
user> (def my-mail (ffirst (d/q '[:find ?eid :where [?eid :mail/uid _]] (new-db-val))))
;=> #'user/my-mail
user> my-mail
;=> 17592186045419
user> (d/entity (new-db-val) my-mail)
;=> {:db/id 17592186045419}
user> (d/touch (d/entity (new-db-val) my-mail))
;=> {:mail/cc #{"matt@bendyworks.com"}, :mail/from "Matt Gauger <contact@mattgauger.com>", :mail/date-sent #inst "2014-03-28T16:35:22.000-00:00", :mail/uid "CAJiAYR90LbbN6k8tVXuhQc8f6bZoK647ycdc7mxF5mVEaoLKHw@mail.gmail.com", :mail/to #{"contact@mattgauger.com"}, :mail/html-body "<div dir=\"ltr\">Body</div>\r\n", :mail/subject "With Matt@Bendyworks in CC", :mail/date-received #inst "2014-03-28T16:35:42.000-00:00", :mail/text-body "Body\r\n", :db/id 17592186045419}
```

## Wrapping up

That's it for this blog post. It took a little setup, but we were able to build up a working Gmail import tool with help from our REPL and some nice Clojure libraries.

Next time, we'll be looking at doing some basic querying of the data, including getting a count of the number of times each email address has sent you an email.

Comments? Questions? Feel free to contact me at [contact@mattgauger.com](mailto:contact@mattgauger.com). I'd love to hear from you.

---

<a name="cds-gmail-footnote-1"></a>
<strong>1</strong> In this case, machine learning *features*, which are the input variables for our learning tasks. Not software features that we a client might ask us to implement. See: [Feature learning - Wikipedia, the free encyclopedia](https://en.wikipedia.org/wiki/Feature_learning).
<a href="#cds-gmail-footnote-1-return">↩</a>


