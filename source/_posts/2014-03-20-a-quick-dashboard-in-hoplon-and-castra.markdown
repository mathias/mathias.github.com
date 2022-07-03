---
layout: post
title: "A quick dashboard in Hoplon &amp; Castra"
date: 2014-03-20 13:29
redirect_from:
  - /blog/2014/03/20/a-quick-dashboard-in-hoplon-and-castra/
---

*Note:* I began writing a much longer blog post that went into a ton of detail about how to build an app dashboard that used Hoplon and Castra. The kind of dashboard that just consumes JSON API endpoints from another app or other data sources. Such dashboards update on the fly in the browser. Many apps these days need a dashboard like this to monitor stats: worker job queues, database size, average response times, etc.

Rather than that long blog post, I wanted to simply show the steps I would take to build such a dashboard with [Hoplon](http://hoplon.io) and [Castra](https://github.com/tailrecursion/castra). I won't go into detail here or explain either Hoplon or Castra &mdash; go read on your own first, and also look into [boot](https://github.com/tailrecursion/boot), the build tool this uses.

If you want to follow along, I've provided a [repo](https://github.com/mathias/gleam). The [README](https://github.com/mathias/gleam/blob/30b4976b313c950c6cc97e64c65036eb21d75378/README.md) has instructions for getting setup. Assuming you have boot installed, you can just run `boot gleam-app` to get started.

So here's how I'd build up a dashboard, in several iterations:

## Static data in the browser:

First, we get some data into the HTML using Hoplon cells, in `index.html`:

```html
<script type="text/hoplon">
  (page "index.html"
    (:refer-clojure :exclude [nth])
    (:require
      [tailrecursion.hoplon.reload :refer [reload-all]]))

  (def articles {:total 422
                 :ingested 419
                 :fetched 0
                 :errored 0
                 :read 315})

  (reload-all 25)
</script>

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>gleam</title>

    <link href="app.css" rel="stylesheet">
  </head>

  <body>
    <header>
      <h1>gleam</h1>
    </header>
    <section>
      <h2>Articles</h2>
      <ul>
        <li>
          <label>Total:</label><text> ~{(get articles :total)}</text>
        </li>
        <li>
          <label>Ingested:</label><text> ~{(get articles :ingested)}</text>
        </li>
        <li>
          <label>Fetched:</label><text> ~{(get articles :fetched)}</text>
        </li>
        <li>
          <label>Errored:</label><text> ~{(get articles :errored)}</text>
        </li>
        <li>
          <label>Read:</label><text> ~{(get articles :read)}</text>
        </li>
      </ul>
    </section>
    <footer>
    </footer>
  </body>
</html>
```

You'll want to `git reset --hard 69b070` to get to this point.

## Move the data to ClojureScript:

In `src/cljs/gleam/rpc.cljs`:

```clojure
(ns gleam.rpc
  (:require-macros
    [tailrecursion.javelin :refer [defc defc= cell=]])
  (:require
    [clojure.set           :as cs]
    [clojure.string        :as s]
    [tailrecursion.javelin :as j :refer [cell]]
    [tailrecursion.castra  :as c :refer [mkremote]]))

(set! cljs.core/*print-fn* #(.log js/console %))

(def articles {:total 422
               :ingested 419
               :fetched 0
               :errored 0
               :read 315})
```
And take out the `(def articles…)` from `index.html.hl`. After boot recompiles everything, you should still see the data in the page.

To get to this point, you can run `git reset --hard d63f299`.

## Move the data to the server side

Change `src/cljs/gleam/rpc.cljs` again, this time to make a remote call for data:

```clojure
(ns gleam.rpc
  (:require-macros
    [tailrecursion.javelin :refer [defc defc= cell=]])
  (:require [clojure.set           :as cs]
            [clojure.string        :as s]
            [tailrecursion.javelin :as j :refer [cell]]
            [tailrecursion.castra  :as c :refer [mkremote]]))

(set! cljs.core/*print-fn* #(.log js/console %))

(defc state {:articles {}})
(defc error nil)
(defc loading [])

(defc= articles (get state :articles))

(def get-state
  (mkremote 'gleam.api.gleam/get-state state error loading))

(defn init []
  (get-state)
  ;; Check every second for new data
  (js/setInterval get-state 1000))
```

On the backend, we need something like this in `src/castra/gleam/api/gleam.clj`:

```clojure
(ns gleam.api.gleam
  (:refer-clojure :exclude [defn])
  (:require [tailrecursion.castra :refer [defn ex error *session*]]))

(def articles {:total 422
               :ingested 419
               :fetched 0
               :errored 0
               :read 315})

(defn get-state []
  {:articles articles})
```

The Hoplon HTML file changes in the script tag at the top of `index.html` to use the new ClojureScript remote call and start up the polling:

```clojure
<script type="text/hoplon">
  (page "index.html"
    (:refer-clojure :exclude [nth])
    (:require
      [gleam.rpc :as gleam]
      [tailrecursion.hoplon.reload :refer [reload-all]]))

  (defc= articles gleam/articles)

  (gleam/init)
</script>
```

To get to this point in the example repo, you can do `git reset --hard 0bad1e5`.

## Real time data

The last step that I will show is to verify that we are in fact getting regular updates of data from the back end.

Change your Castra Clojure file to look like this:

```clojure
(ns gleam.api.gleam
  (:refer-clojure :exclude [defn])
  (:require [tailrecursion.castra :refer [defn ex error *session*]]))

(defn articles []
  (let [ingested (rand-int 300)
        fetched (rand-int 300)
        errored (rand-int 300)
        read (rand-int 300)]
    {:total (+ ingested fetched errored read)
     :ingested ingested
     :fetched fetched
     :errored errored
     :read read}))

(defn get-state []
  {:articles (articles)})
```

To get to this point, you can do a `git reset --hard f19325`

## Talking to a remote service.

The last step here is left as an exercise for the reader. You can imagine replacing the `articles` function in `src/castra/gleam/api/gleam.clj` with something that polls a remote JSON API for data. Or you could look at my social news app [gnar](http://github.com/mathias/gnar) for inspiration on using a Postgres database for data.

I hope to finish up a post with full explanations soon. Castra is relatively new, and it's worth explaining how some of the pieces fit together. My explanation should include more complicated interaction. like user authentication. I will be publishing that blog post after I get back from [ClojureWest](http://clojurewest.org) next week!

Let me know what you thought of this post by shooting me an [email](mailto:contact@mattgauger.com). I'd love to hear from you.
