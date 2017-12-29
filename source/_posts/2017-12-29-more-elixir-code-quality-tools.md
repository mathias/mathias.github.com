---
layout: post
title: More Elixir Code Quality Tools
---

The Elixir community is fast-moving, and there's always new things to learn.  [Andrew Summers](https://github.com/asummers) wrote in to mention a few more tools that I didn't cover in my [Elixir Code Quality Tools](/2017/11/21/elixir-code-quality-tools/) blog post:

# [wobserver](https://github.com/shinyscorpion/wobserver)

In my last post, I mentioned Erlang's observer GUI. The Erlang observer runs as a small native app and charts things like memory used, BEAM process counts, supervisor trees, and more.

`wobserver` runs as a web app and shows the same kind of information in your browser. Best of all, you can add it as a Plug into your Phoenix or Plug-based web apps. There’s a lot of information available to explore. There's also an API that you can integrate or build your own reporting and graphing around.

# List dependencies with `mix`

In Clojure, we used `lein deps :tree` to see a tree of all dependencies in Clojure. In Elixir, we can use the` mix app.tree` task to see a tree of all the dependencies in our current application. For example:

```
$ mix app.tree
annotatex
├── elixir
├── logger
│   └── elixir
├── runtime_tools
├── guardian
... output truncated ...
```

# See outdated dependencies with `mix`

Outdated dependencies don't always make themselves known. While following mailing lists for CVEs is important, I'd rather have a tool notify me  of new versions of a dependency. In Ruby, we can use `gem outdated`, `bundler outdated` and even install tools like [bundler-audit](https://github.com/rubysec/bundler-audit). With Elixir, we can use this task in `mix`. It outputs a table with color-coding, which I cannot fully reproduce here, so you'll have to try it for yourself.

```
$ mix hex.outdated
```

# Alias mix tasks

There's several reasons to use task aliases. One is to rename a longer task name to something shorter, because that task is often run. The other is to combine two or more tasks into one alias so that you can run them in that order. This helps you to build workflows and repeat steps necessary for setup each time. This is documented in the excellent [mix docs](https://hexdocs.pm/mix/Mix.html#module-aliases).

# Wrapping up

Thanks again to Andrew Summers for these suggestions. I hope that you find them useful. Have more that I've missed? [Get in touch](mailto:contact@mattgauger.com), I'd love to hear from you.
