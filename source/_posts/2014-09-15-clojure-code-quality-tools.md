---
layout: post
title: "Clojure Code Quality Tools"
date: 2014-09-15 13:39
---

I work with many programming languages on a daily basis. As a polyglot programmer, I've come to appreciate tools that help me follow best practices. For JavaScript, there's the excellent [jshint](http://jshint.com/). When I need to verify some XML, there's [xmllint](http://xmlsoft.org/xmllint.html). In a Ruby on Rails project, I can count on the [rails\_best\_practices](http://rubygems.org/gems/rails_best_practices) gem. For Ruby smells, I prefer the combo of [rubocop](https://github.com/bbatsov/rubocop). There's tools like [SimpleCov](https://github.com/colszowka/simplecov) to measure and show test suite coverage on my Ruby projects. [cane](https://github.com/square/cane) helps me to ensure line length, method complexity, and more in my Ruby code. [Syntastic](https://github.com/scrooloose/syntastic) helps bring real syntax checking to vim for many langauges. Every day, more open source tools are introduced that help me to improve the quality of the software that I write.

It follows that when I write Clojure code, I want nice tooling to help me manage code quality, namespace management, and out-of-date dependencies. What tools do I use on a day-to-day basis for this? In this post, I'll show 5 tools that I use in my workflow every day on Clojure projects, and also provide some other tools for further exploration. Most of these tools exist as plugins to the excellent [Leiningen](http://leiningen.org/) tool for Clojure.

## lein deps :tree

In the past, `lein deps` was a command that downloaded the correct versions of your project's dependencies. Running `lein deps` is no longer necessary, as each lein command now checks for dependencies before executing. But `deps` provides an interesting variant for our uses: `lein deps :tree`.

The `:tree` keyword at the end instructs lein to print out your project's dependencies as a tree. This itself is a good visualization, but not what we're looking for. The tree command will first print out any dependencies-of-dependencies which have conflicts with other dependencies. For example, here's what `lein deps :tree` says for one of my projects:

<script src="https://gist.github.com/mathias/8eca3548f751bec6ea55.js"></script>

As you can see, the tool suggests dependencies that request conflicting versions, and how we can modify our `project.clj` file to resolve those conflicting versions by excluding one or the other. This isn't always very useful, but when you run into issues because two different Clojure libraries require two wildly different `joda-time` versions (a situation I have run into before), it will be good to know what dependencies are causing that issue and how you might go about resolving it.

Note that this functionality disappeared in Leiningen 2.4.3 but is back in 2.5.0, so make sure you run `lein upgrade`!

## [lein-ancient](https://github.com/xsc/lein-ancient)

This plugin to `lein` exists simply to check your project for outdated dependencies. Without [lein-ancient](https://github.com/xsc/lein-ancient), I'd be unable to keep up with some of the faster-moving libraries in the Java and Clojure world.

After adding ancient to your `~/.lein/profiles.clj`, running the `lein ancient` command yields output on the same project as before:

<script src="https://gist.github.com/mathias/bac5e554f971d7aa462f.js"></script>

Whoops! Looks like I haven't been keeping up to date with my dependencies. `lein ancient` makes checking for new dependency versions easy. Further, thanks to the ubiquity of [semantic versioning](http://semver.org/) in Clojure projects, it is usually quite safe to bump the minor versions (0.0.x) of dependencies.

You can also use lein-ancient to find outdated lein plugins in your `~/.lein/profiles.clj` file. Just run it with the `profiles` argument:

<script src="https://gist.github.com/mathias/02b999542ea837b87e30.js"></script>

## [lein kibit](https://github.com/jonase/kibit)

As we gain experience and confidence in a programming language, we begin to talk about whether we're writing *idiomatic* code. I'd argue that idiomatic code is code that accomplishes a goal with proper use of language features, in a way that other developers familiar with that language would understand. A simpler way to say it might be: idiomatic code uses the community-accepted best practices of how to do something.

Clojure's design seeks to solve some problems found in older Lisps, as well as add in niceties like complementary predicate functions. A good example of these convenient complementary functions are `if` and `if-not`. Clojure also contains several cases of simplification for common usage. For example, when you don't need an else clause on an `if`, you can use the `when` macro.

Wouldn't it be great if there was someone who was well-versed in Clojure idioms pairing with you and offering suggestions? That's exactly what [kibit](https://github.com/jonase/kibit) does.

Running against a project I'd set up to contain some smells, `lein kibit` found:

<script src="https://gist.github.com/mathias/fc0d446aeb90f44a6731.js"></script>

These kinds of small improvements are all over our Clojure projects. They're not show-stopper bugs, but they're small places for improvement.

Kibit's suggestions are almost always logically equivalent to the original code. Still, I always do some smoke-testing to ensure the code still works after using Kibit's suggestion, and it generally does. Problems I frequently fix with Kibit are replacing `if` statements with the `when` macro, as well as places where the code checks for empty seqs, or that I can simplify nil checks.

You can point lein kibit at a specific namespace by appending the path, like this: `lein kibit src/foo/bar.clj`

Kibit catches many cases where there is a more-idiomatic way to express what you are trying to do. I recommend running it often. In fact, it's possible to use [kibit in your emacs buffers](https://github.com/jonase/kibit#usage-from-inside-emacs) if you want it to be that much more convenient and real-time.

## [Eastwood](https://github.com/jonase/eastwood)

For linting Clojure code, there's Eastwood. It is similar in functionality to Kibit, bit will catch different issues than Kibit. Built on two interesting Clojure projects: [tools.analyzer](https://github.com/clojure/tools.analyzer) and [tools.analyzer.jvm](https://github.com/clojure/tools.analyzer.jvm), Eastwood does a powerful examination of your code inside the JVM. It is worth highlighting that since Eastwood loads your code to analyze it, it might trigger any side effects that happen when your code loads: writing files, modifying databases, etc. Note that it only loads the code; it does not execute it.

After adding `eastwood` to your lein `profiles.clj`, simply run: `lein eastwood` and you will see output like:

<script src="https://gist.github.com/mathias/b93cea02293eac933bee.js"></script>

That's a lot of problems for a simple file! Notice how one mistake got caught for two reasons: A misplaced docstring (placed after the arguments vector) becomes just a string in the function body that will be thrown away.

Another nice catch that Eastwood provides is detecting the redefinition of the var `qux` in the file.

But Eastwood covers a lot more cases than just vars being def'd more than once. See the [full list](https://github.com/jonase/eastwood#whats-there) to find out what else it does. There's a few linters that are disabled by default, but they might make sense to enable for your project.

Frequently running lint tools can help prevent subtle problems that come from code that looks correct but contains some small error. Eastwood is less concerned with style than tools like JSHint are, but we have other tools that cover stylistic concerns.

## [lein bikeshed](https://github.com/dakrone/lein-bikeshed)

This is a relative newcomer to my own tool set. [lein bikeshed](https://github.com/dakrone/lein-bikeshed) has features related to the low-hanging fruit in our Clojure code: lines longer than 80 characters, blank lines at ends of files, and more. It will also tell you what percentage of functions have docstrings. Like other tools mentioned here, it is a lein plugin that you add to your `profiles.clj`.

A run of `lein bikeshed` on its own source (which purposefully includes some code designed to fail) looks like this:

<script src="https://gist.github.com/mathias/271e06ebce8fe6428b83.js"></script>

Bikeshed might give a lot of output for your existing projects, but the warnings are worth investigating and addressing. You can always silence the long-lines warning if it doesn't matter to you with the `-m` command line argument.


## Tying it all together with a Lein alias

Wouldn't it be great to run all these tools frequently, so that you can check for as many problems as possible? Well, you can, with a lein alias. (The lein wiki documents aliases in the [lein sample.project.clj](https://github.com/technomancy/leiningen/blob/stable/sample.project.clj#L195-L211).)

In `~/.lein/profiles.clj`, inside your `:user` map, add the line:

<script src="https://gist.github.com/mathias/eef9f3f3e9e0ba40cb78.js"></script>

Now, when you want to run all these tools at once on a project, you simply invoke `lein omni`. I use this alias on all my Clojure(Script) projects. I have grown accustomed to seeing the kinds of output that a clean Clojure project will have.

It's worth noting that I don't run Eastwood unless it is necessary for the project. When it is necessary, I override the alias in the project's `project.clj` to run Eastwood as well.

This command can take some time to complete, but with an alias we're only spinning up lein once.

## And a bash alias

The output of `lein omni` can be long, which can either result in a lot of scrolling or neglecting to run the command due to the inconvenience. To help manage the length of the output, I've created a bash alias that runs the plugins and pipes them to less.

My personal bash alias also runs midje at the end. You can choose whether to run the tests for your own alias. That's just my personal preference.

<script src="https://gist.github.com/mathias/8b6a0040fcd7e4ae890f.js"></script>

Note that just like running the lein alias above, this may take a bit of time. Since we're piping it to `less`, it might take awhile before `less` receives output. While it is still running, output will periodically show up at the bottom of the `less` buffer. You can use both Emac's and vim's movement commands in `less` to advance the buffer. I find `less` to be more manageable for scrolling through output than switching to `tmux`'s history scrolling mode.

## Managing your namespaces: [lein slamhound](https://github.com/technomancy/slamhound)

Namespace management often becomes an issue on nontrivial Clojure projects. Actively developing a project means managing the functions we pull in from other namespaces and from libraries. These require statements can often get out of date. Often, they're either missing namespaces that are needed, or containing requirements for old functions that are no longer used in the current code.

[slamhound](https://github.com/technomancy/slamhound) is a tool that can help to manage dependencies in your namespaces. It knows how to require and import Clojure and Java dependencies, and can remove stale requires that are no longer necessary. Slamhound can often fix missing requires for functions that it can resolve.

**Note: slamhound rewrites the namespace macros in your project's .clj files!** I recommend only running it on code that's committed to git (or whatever you use as a VCS) so that you can review and  rollback any changes it makes.

The most basic way to use slamhound is to add it to your `~/.lein/profiles.clj` as a dependency. Then add this alias:

<script src="https://gist.github.com/mathias/f3799e60c63b0aebf17e.js"></script>

Now you can use slamhound on a project by running `lein slamhound` in the project's directory. There's also REPL and Emacs support, which you can learn more about in the [slamhound README](https://github.com/technomancy/slamhound#repl-usage).


## Measuring test coverage with [cloverage](https://github.com/lshift/cloverage)

It is often claimed that less unit testing is necessary in Clojure because Clojure is functional and makes use of immutable data structures. And it is true that with functional programming, most tests are simple: given some input, the output should be a certain value.

Some would even argue that Clojure functions should be well-factored enough into simple functions that the behavior of the function is apparent and requires no tests. Still others maintain that developing in the REPL is as good as writing unit tests, since functions are constantly evaluated and integrated with this style of development.

That said, there's still mutable Java code to interop with, there's still the necessary evil of functions with side effects, and we might want to check the *structure* of the data we're producing in our functions rather than the value of it. For all those reasons and to check that I don't introduce regressions, I tend to write unit tests in Clojure.

This blog post isn't a platform to argue for or against testing Clojure. But when you do test, you may wonder how to tell how much test coverage your test suite has. How do we know at a glance what percentage of our namespaces is being tested? And how do we find lines that are never being exercised in our tests? After all, we can't improve what we don't measure.

That's where [cloverage](https://github.com/lshift/cloverage) comes in. Cloverage is another lein plugin, so it gets added to `~/.lein/profiles.clj` like the others. Then run `lein cloverage` in your project; it will run the test suite and generate a coverage report.

The coverage report appears in `target/coverage` as HTML files, broken down by namespace.

You can still use Cloverage even if you don't use `clojure.test`. I use [midje](https://github.com/marick/Midje) in most of my tests. To use Cloverage in those situations, wrap your tests in a `deftest`.

Since `deftest` has a hyphenated Clojure keyword as its identifier, and Midje facts have a string as an identifier, I've come to use the `deftest` to group related tests together. Usually this means naming the group of tests after the function I'm testing. Then I name Midje facts after the situation that the fact exercises. This makes sense to me because it fits well with the hierarchy of rspec unit tests in Ruby.

Here's an example of using this approach:

<script src="https://gist.github.com/mathias/94e1a4d7b8bce7c02e23.js"></script>


Cloverage also outputs a `coverage.txt` file that might be useful for use with services like [Coveralls](http://coveralls.io). I haven't used this, so I can't comment on its usefulness.

If you're using [speclj](https://github.com/slagyr/speclj) for your tests, you might run into some issues getting Cloverage to play nice. I don't use speclj often, so when I couldn't get it to work with Cloverage, I didn't pursue the issue.

## Final Thoughts

In this post, I covered 5 tools to add to your workflow all the time, and some others that might be useful in certain cases. I'm sure there's more tools out there that are useful that I don't know about, and I'd love to hear about them.

I'm also thinking about writing some posts about other development tools that I use, particularly how I use [midje](https://github.com/marick/midje) to test, and how you can benchmark code with [perforate](https://github.com/davidsantiago/perforate). If you're interested in those topics, get in touch and let me know.

Have fun and enjoy your cleaner codebase with these tools in your tool belt!

---

Interested in commenting or contacting me? Send an email to [contact@mattgauger.com](mailto:contact@mattgauger.com). Thanks!

