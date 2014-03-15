---
layout: post
title: "Agile Data Science: Review and Thoughts"
date: 2014-03-14 19:53
---

<a href="http://shop.oreilly.com/product/0636920025054.do">
  <img src="images/agile_data_science_cover.gif" alt="Agile Data Science cover" style="display: block; float:right; margin: 10px;">
</a>

Recently, I read the book [Agile Data Science](http://shop.oreilly.com/product/0636920025054.do) by Russell Jurney. The book covers data science and how the author applies an agile workflow and powerful tooling to accomplish tasks. While I found the book interesting, and would recommend it as a good introduction, I have some issues with the book that I'd like to discuss. I'd like to go over the book and the tools briefly, if only to save my thoughts for later.

A quick note: data science is being defined by the web community as the process of analyzing large data sets with statistics and other approaches. That definition is ongoing and changing all the time. Big Data is the term that the industry seems to be using for such large datasets. You'll also see the terms machine learning, analytics, and recommender systems mentioned: these are all various sub-topics that I won't cover in depth here.

The book centers around the use of [Hadoop](http://hadoop.apache.org/). In turn, Hadoop is commanded by writing and running [Apache Pig](https://pig.apache.org/) scripts in the book. Pig allows you to write workflows in a high-level scripting language that may compose many Hadoop jobs into one system. With Pig, you need not worry about the specifics of what each Hadoop job is doing when you write a Pig script.

Hadoop is patterned after Google's [MapReduce paper](http://static.googleusercontent.com/media/research.google.com/en/us/archive/mapreduce-osdi04.pdf). Google had large clusters of computers and large data sets that it wanted to process on those clusters. What they came up with was a simple idea: Write a single program that would specify a `map` function to run across tuples of all the input data. Add a `reduce` function that compiles that output down into the expected format. MapReduce coordinates deploying the program to each worker machine, divvying up the input data across the different machines, gathering up the results, and handling things like restarts after failures. This was a huge success inside Google, and Hadoop implements that architecture with improvements.

It should be noted that this MapReduce architecture is essentially batch-processing for large amounts of data. The same system it would have a hard time with streams of data.

Hadoop is, unfortunately, my first stumbling block with learning to process big data.

Configuring and running Hadoop is not easy. I have far more experience as a developer than a sysadmin (or today's term: devops engineer). There exists more than one "distribution" of Hadoop and more than one versioning scheme between those. This means that understanding what's available, how to configure it, and whether search results are relevant to you is quite hard for the unexperienced.  Imagine the confusion of trying to install a Debian Linux distro and only being able to find instructions for Red Hat Linux; further, not being able to tell what the problem was when it wouldn’t boot and printed a Debian-specific error. 

It seems like Hadoop is designed for to be run by someone whose full-time job is to configure and maintain that cluster. That person will need to have enough experience with all the different choices to have an opinion on them. For a developer wanting to run things locally before committing to configuring (and paying for!) a full cluster out on AWS, it was daunting.

Luckily for me, [Charles Flynn](https://github.com/charlesflynn) has created a neat repo on Github at [charlesflynn/agiledata](https://github.com/charlesflynn/agiledata). It builds a local development VM for the Agile Data Science book, with all the dependencies installed and the book's code in the right place to run. With that project, I was able to get up and running with the project quickly and found it useful to not have to sink anymore time into configuring Hadoop. I'd like to give another shout-out to Charles for this great resource and the work done to make sure it works.

The book has the reader work with email data: your Gmail inbox pulled locally for analyzing. I thought this was neat, in itself. Many data science tools use free datasets; as a result working with those datasets may not be the most interesting problem space to you. But insights about your own communication and how others communicate with you is something you might find more interesting.

After explaining Hadoop, Pig, and a few other tools, the rest of the book follows a fairly lightweight "recipe" format. Each chapter explains the goal and how it fits in an "agile data science" workflow. Then, some code is presented, and then we see what kinds of results we can take from that step. Once this pattern is set up, the book moves fairly quickly through some rather interesting data wrangling. By the end, the reader has built several data analysis scripts and a simple web app put together with MongoDB, Python Flask, and D3.js graphs to display all the results.

At times, though, the quick recipe format seemed to explain too little. There was little explanation of how Pig script syntax worked or how to understand what was going on under the covers. What this book is not: an exhaustive guide to how to write Pig scripts, how to pick approaches to analyzing a dataset, or how to compose these systems in production in the wild.  Also missing were any mention of performance tuning or what other algorithms might be considered.

Which seems like an awful lot to be missing, but for this book that would have been diversions that bogged the book down.

To the author's benefit, I finished the book, and finished it far faster than I expected I would. I cam away having done almost all of the book's examples (helped a great deal by the excellent virtual machine repo from Charles Flynn mentioned above). And, I had a deeper understanding and respect for tools that I'd never used before.

## Final thoughts

When it comes down to it, I wouldn't recommend Agile Data Science to read on its own. I'd recommend that you used it as a quick introductory book to build familiarity and confidence, so that you could dive into a deeper resource afterwards. I'd also recommend it if you're a developer who isn't going to be doing data science as your full time job but are curious about the tools and practices, this book would be a good read.

## What I'm doing next

Almost immediately after finishing this book, I attended an event at a nearby college to talk about [Apache Storm](http://storm.incubator.apache.org/). Our company blog [covered the event](http://bendyworks.com/geekville/articles/2014/2/uw-big-data-event-presents-storm) if you're curious.

Storm is a tool that came out of Twitter for processing streams of big data. If you think about it, Twitter has one of the biggest streaming data sets ever. They need to use that streaming data for everything from recommendations to analytics to top tweet/hashtag rankings.

After attending the event and having run a word-counting topology (Storm's term for a workflow that may contain many data-processing jobs) out on a cluster, I began to see the potential of using Storm.

Plus, Storm is far friendlier to local development on a laptop. One can run it with a simple command line tool or even from inside your Java or Clojure code. Or, perhaps most simply, from inside the Clojure REPL.

The other plus here is that Storm is mostly written in Clojure and has a full Clojure API. Combined with a few other Clojure tools that I prefer, like [Datomic](http://www.datomic.com/), [Ring](https://github.com/ring-clojure/ring), and [C2](http://keminglabs.com/c2/), I can see a toolset similar to that used in Agile Data Science. This toolset has the benefit of using the same language for everything. And, Clojure is already well-suited for data manipulation and processing.

So I began to rewrite the examples in Agile Data Science in Clojure. I am hoping to make enough progress to begin posting some of the code with explanations in blog format. Stay tuned for that.
