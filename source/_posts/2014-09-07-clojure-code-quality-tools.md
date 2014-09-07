---
layout: post
title: "Clojure Code Quality Tools"
date: 2014-09-07 10:35
---

I work with many programming languages on a daily basis. As a polyglot programmer, I've come to appreciate tools that help me follow best practices. For JavaScript, there's the excellent [jshint](http://jshint.com/). When I need to verify some XML, there's [xmllint](http://xmlsoft.org/xmllint.html). In a Ruby on Rails project, I can count on the [rails\_best\_practices](http://rubygems.org/gems/rails_best_practices) gem. For Ruby smells, I prefer the combo of [rubocop](https://github.com/bbatsov/rubocop). There's tools like [SimpleCov](https://github.com/colszowka/simplecov) to measure and show test suite coverage on my Ruby projects. [cane](https://github.com/square/cane) helps to ensure things like line length and complexity are managed and consistent in my Ruby code. [Syntastic](https://github.com/scrooloose/syntastic) helps bring real syntax checking to vim for many langauges. Every day, more tools are introduced that help me to improve the quality of the software that I write.

It follows that when I write Clojure code, I want nice tooling to help me manage code quality, namespace management, and out-of-date dependencies. What tools do I use on a day-to-day basis for this? In this post, I'll show 4 tools that I use in my workflow every day on Clojure projects, and also provide some other tools resources for further exploration. Most of these tools exist as plugins to the excellent [Leiningen](http://leiningen.org/) tool for Clojure.

## [lein ancient](https://github.com/xsc/lein-ancient)

This plugin to `lein` exists simply to check your project for outdated dependencies. Without [lein ancient](https://github.com/xsc/lein-ancient), I'd be unable to keep up with some of the faster-moving libraries in the Java and Clojure world.

After adding it to your `~/.lein/profiles.clj`, running the `lein ancient` command yields output on the same project as before:

<script src="https://gist.github.com/mathias/bac5e554f971d7aa462f.js"></script>

Whoops. Looks like I haven't been keeping up with my dependencies. `lein ancient` makes checking for new dependency versions easy. Further, thanks to the ubiquity of [semantic versioning](http://semver.org/) in Clojure projects, it is usually quite safe to bump the minor versions (0.0.x) of dependencies. (Just be sure to run your tests!)

## [lein kibit](https://github.com/jonase/kibit)

As we gain experience and confidence in a programming language, we begin to talk about whether we're writing *idiomatic* code. I'd argue that idiomatic code is code that accomplishes a goal with proper use of language features, in a way that other developers familiar with that language would understand. A simpler way to say it might be idiomatic code uses the community-accepted best practices of how to do something.

In Clojure, there are many language features that are designed to solve problems found in older Lisps, as well as many complementary functions. A good example of these convenient complementary functions are `if` and `if-not`. Clojure also contains several functions that deal with different number of arguments to deal with different situations: For example, when you don't need an else clause on an `if`, you can use `when`.

Wouldn't it be great if there was someone who was well-versed in Clojure idioms pairing with you and offering suggestions? That's exactly what [kibit](https://github.com/jonase/kibit) does.

Running against a project I'd purposefully left some smells in, `lein kibit` found:

<script src="https://gist.github.com/mathias/fc0d446aeb90f44a6731.js"></script>

These kinds of small improvements are all over our Clojure projects. They're not show-stopper bugs, but they're small places for improvement.

Kibit's suggestions are almost always logically equivalent to the original code. Still, I always do some smoke-testing to ensure the code still works after using Kibit's suggestion, and it generally does. Problems I frequently fix with Kibit are `if` statements that can be replaced with the `when` macro, as well as places where we check for empty seqs, can simplify nil checks, etc.

You can point lein kibit at a specific namespace by appending the path, like this: `lein kibit src/foo/bar.clj`

Kibit catches many cases where there is a more-idiomatic way to express what you are trying to do. I recommend running it often. In fact, it's possible to use [kibit in your emacs buffers](https://github.com/jonase/kibit#usage-from-inside-emacs) if you want it to be that much more convenient and real-time.

## [Eastwood](https://github.com/jonase/eastwood)

For linting Clojure code, there's `eastwood`. It is similar in functionality to Kibit, bit will catch different issues than Kibit. This tool is built on two interesting Clojure projects: [tools.analyzer](https://github.com/clojure/tools.analyzer) and [tools.analyzer.jvm](https://github.com/clojure/tools.analyzer.jvm). It should be noted that since `eastwood` actually loads your code to analyze it, it might trigger any side effects that happen when your code is loaded: writing files, modifying databases, etc. Note that it only loads the code, it does not execute it, so execution side effects should not happen.

It might be worth thinking about what your code does and whether some of the values you `def` when the file is loaded might be better suited to a function that that sets up your code before it is run. (See the section at the end on "REPL-driven systems" for more thoughts on this.)

After adding `eastwood` to your lein `profiles.clj`, you simply run: `lein eastwood` and you will see output like:

<script src="https://gist.github.com/mathias/b93cea02293eac933bee.js"></script>

That's a lot of problems for a simple file! Notice how one mistake got caught for two reasons: A misplaced docstring (placed after the arguments vector) because just a string in the function body, which would be thrown away. I also purposefully redefined the var `qux` to show how long, complicated namespaces can contain redefinitions that were not expected.

Eastwood covers a lot more cases than just vars being def'd more than once. See the [full list](https://github.com/jonase/eastwood#whats-there) to find out what else it does. There's a few linters that are disabled by default, but they might make sense to enable for your project.

Frequently running lint tools in your project can help prevent the kind of subtle problems that come from code that looks correct but contains some small error. Eastwood is less concerned with style than tools like JSHint are, but we have other tools in the Clojure space that covers stylistic concerns.


## [lein bikeshed](https://github.com/dakrone/lein-bikeshed)

This is a relative newcomer to my own tool set. [lein bikeshed](https://github.com/dakrone/lein-bikeshed) has features related to the low-hanging fruit in our Clojure code: lines longer than 80 characters, blank lines at ends of files, and more. It will also tell you what percentage of functions have docstrings. Like other tools mentioned here, it is installed as a lein plugin in your `profiles.clj`.

A run of `lein bikeshed` on its own source (which purposefully includes some code designed to fail) looks like this:

<script src="https://gist.github.com/mathias/271e06ebce8fe6428b83.js"></script>

Bikeshed might give a lot of output for your existing projects, but some of the warnings are worth addressing. And you can always silence the long lines warning if it doesn't matter to you with the `-m` command line argument.


## Tying it all together with a Lein alias

Wouldn't it be great to run all these tools frequently, so that you can check for as many problems as possible? Well, you can, with a lein alias. (lein aliases are documented in the [lein sample.project.clj](https://github.com/technomancy/leiningen/blob/stable/sample.project.clj#L195-L211).)

In `~/.lein/profiles.clj`, inside your `:user` map, add the line:

<script src="https://gist.github.com/mathias/eef9f3f3e9e0ba40cb78.js"></script>

Now, when you want to run all of these tools at once on a project, you simply have to invoke `lein omni`. I use this alias on all my projects to check the quality of my Clojure code often, at least before every commit. I have grown accustomed to seeing the kinds of output that a clean Clojure project will have.

Note that I don't typically run Eastwood as part of this unless it is necessary for the project, in which case I'd probably override the alias in the project's `project.clj` to run Eastwood as well.

## Bash alias

The output of `lein omni` can be very long, which can either result in a lot of scrolling or simply ignoring to run the command due to its length. To help manage the length of the output, I've also created a bash alias that runs the plugins and pipes them to less, as well as runs my midje tests at the end. You can choose whether or not you want to run the tests at the end, that's just my personal preference.

<script src="https://gist.github.com/mathias/8b6a0040fcd7e4ae890f.js"></script>

Note that just like running the lein alias above, this may take a bit of time. Since we're piping it to `less`, it might take awhile before the output is sent to less and you can scroll through it. While it is still running, output will periodically show up at the bottom of the `less` buffer. You can use both Emac's and vim's movement commands in `less` to advance the buffer. I find `less` to be more manageable for scrolling through output than switching to tmux's history scrolling mode.

## Advanced usage

### lein slamhound: modifying your namespaces

Namespace management often becomes an issue on nontrivially-large Clojure projects. I've often run into circular dependency clashes due to needing some function in two places. Slamhound exists not to resolve those kinds of issues, but to help you simplify how you require namespace


### Test coverage with midje and lein-cloverage

https://github.com/lshift/cloverage
https://github.com/marick/lein-midje

### Developing a REPL-driven system with component

http://thinkrelevance.com/blog/2013/06/04/clojure-workflow-reloaded
https://github.com/stuartsierra/component
https://github.com/mowat27/reloadable-app

### Benchmarking with perforate

https://github.com/davidsantiago/perforate

## Final Thoughts

That's all! I did write a bit more on using `lein deps :tree` to find dependency-of-dependencies conflicts, but the functionality has since stopped working in recent versions of Leiningen. If you're interested in that section, I've put it online as a [gist](https://gist.github.com/mathias/2af80c34edbc53582f53). If that tool starts working again in Leiningen, I'll likely write a quick follow-up post for it.

I'm sure there's more tools out there that are useful, and I'd love to hear about them. Have fun and enjoy your cleaner codebase with these tools in your toolbelt!

---

Interested in commenting or contacting me? Send an email to contact@mattgauger.com. Thanks!

