---
layout: post
title: "Elixir Code Quality Tools"
---

My [Clojure Code Quality Tools](/blog/2014/09/15/clojure-code-quality-tools/) post remains one of the more popular articles on this blog. Since then, I've been writing a lot more Elixir code. I thought it'd be fun to write a similar post on what to use with the Elixir programming language.

By default, Elixir will do a good job with pattern matching and unused functions warnings, as well as giving you deprecation warnings. But as you learn and progress in mastery of Elixir, you'll want more feedback. That's where code quality tools come in.

As indicated in the original post, tools should help us follow best practices. The top issues I run into with Elixir code are checking my function signatures and pattern matching to ensure I've caught all cases, enforcing good style, and checking my code coverage. This post introduces 5 tools that are now a part of my Elixir workflow, depending on the project.

This post will have less examples than the last, but you can refer to each project's README to help you get started. Instead, I'll cover why you might want to use each of these tools and what problems they solve.

# [doctests](http://elixir-lang.org/getting-started/mix-otp/docs-tests-and-with.html#doctests)

Built in to Elixir itself, doctests are a simple way to couple examples of useage where your function definition lives, in the source. They define an example call from an `iex` prompt, and show what the return should be. When you set up a simple test file in the suite to run doctests, it will automatically check that the examples match the actual function call response. All it takes is a test file such as:

```
defmodule Alohomora.ResourceTest do
  use ExUnit.Case, async: true
  doctest Alohomora.Resource
end
```

And to test functions with doctests in your `Alohomora.Resource` namespace. Best of all, there's nothing extra to add -- these tests will run when you run `mix test`.

# [dialyxir](https://github.com/jeremyjh/dialyxir)

This library is actually a set of mix tasks on top of the popular Dialyzer tool for Erlang. Dialyzer, if you haven't encountered it yet, is a DIscrepancy AnaLYZer for ERlang programs. That is to say, it finds dead code, type issues, and unnecessary tests. In my experience, it finds unreachable branches, and it finds tuple returns that aren't matching a pattern where they're used. These two seem to be the bulk of the things it finds for me, at least. It will also find functions that aren't defined for the number of parameters you're passing, but it seems to have issues with certain libraries I use -- those libraries do in fact define functions with that signature.

To really get the power of Dialyzer, you'll to start [including type specs](https://hexdocs.pm/elixir/typespecs.html) in your source.

# [dogma](https://github.com/lpil/dogma) and [credo](https://github.com/rrrene/credo)

Style guides help a team to write consistent code, more than they specify architecture patterns or idiomatic solutions. If you want to start applying a style guide to your Elixir code, look no further than dogma. As indicated on its README, "It's highly configurable so you can adjust it to fit your style guide, but comes with a sane set of defaults so for most people it should just work out-of-the-box." I'd recommend starting with its default style guide and seeing what it yells about.

The kinds of things that dogma will tell you about are lines too long, trailing whitespace, and so on. You've probably seen similar output if you use a tool like `rubocop` in Ruby.

Credo has some overlap with dogma, but it does far more. This tool is more concerned with code smells. Some examples are checking function complexity, negated conditionals, and idiomatic ways to format your pipe operators and one-line functions. You can read up on the [credo docs](https://github.com/rrrene/elixir-style-guide) to understand everything it checks for.

Ultimately, you may feel like you only need one or the other. For myself, I use credo with `mix credo --strict`.

# [ExCoveralls](https://github.com/parroty/excoveralls)

Code coverage in your tests is an important metric to keep track of. While striving for 100% code coverage isn't always worth it, it is good to know whether you're exercising the code you think you are, and ensuring that all edge cases and error cases that you coded for have been checked with a test.

Installing ExCoveralls in your project will allow you to print out your code coverage for each module to the shell, as HTML, or to post the code coverage to Coveralls.io. ExCoveralls also supports being run from a few different CI tools including CircleCI, Semaphore, and Travis. If you don't need all this, you could look into [ExCov](https://github.com/mrinalwadhwa/excov) or simply run `mix test --cover` -- although I find this built-in mix task's output to be the least useful.

# The Erlang observer GUI

This one is built in, simply launch it from your `iex terminal:

```
iex> :observer.start
```

And it will launch a GUI tool. The GUI has charts of memory and processing done, as well as a graph of application supervisor trees. Honestly, there's a lot more in this tool than I've had time to explore and learn about.

# `mix profile.fprof`

This is another built-in tool that you can use. Profiling might not be the first tool you need when developing, but when you want to understand and trace what your code is doing, the `fprof` tool's output can be incredibly handy. Make sure you run this with `MIX_ENV=prod` when you use this. It is also possible to [wrap fprof to profile slow test cases](https://selfamusementpark.com/profiling-a-slow-elixir-test), which I have found useful in the past. There's other libraries that you can install for profiling and tracing Elixir, but so far, `mix profile.fprof` has worked well enough for me.

# Final Thoughts

This post was 5 tools for your Elixir workflow. If you've been working in Elixir for awhile, you may be already using them. And there's probably more tools that I don't know about, out there.

Let me know if you found this blog post useful, or if you have any other tools to recommend!

# Update December 27, 2017:

I've written up a [new blog post](/2017/12/27/more-elixir-code-quality-tools/) that covers tools submitted by reader Andrew Summers.
