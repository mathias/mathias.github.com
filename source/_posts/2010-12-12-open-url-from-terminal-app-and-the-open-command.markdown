---
layout: post
title: Open URL from Terminal.app and the 'open' command
published: true
redirect_from:
  - /blog/2010/12/12/open-url-from-terminal-app-and-the-open-command/
---

More and more as I blog, I find I like to post little tips, and beginners thank me for showing them something new, More advanced users may have simply overlooked whatever I'm sharing, so they can find it useful, too. So in that vein, I just reminded myself of a little Mac OSX Terminal.app trick I use all the time, and wanted to post it here.

When you have a URL in Terminal.app, say in a README file you're reading, or coming back from a dig/whois command, you can just right-click (option-click) on the URL and click Open URL. It's fast, it works, and it saves me a few milliseconds of copy/pasting it. Awesomest trick ever? Not really. Useful? Definitely.

An alternative form of this is to use the Mac OSX "open" command on any number of things: Files, applications, URLs. Here's how it looks:

```
banshee:diaspora mathiasx$ open http://joindiaspora.com
banshee:diaspora mathiasx$ open README.md
banshee:diaspora mathiasx$ open /Applications/Google\ Chrome.app/
```

That will open the [joindiaspora.com](https://joindiaspora.com/) site in your default browser, a file called README.md in whatever your default text editor is, and the final command will open Google Chrome if it isn't open, otherwise it will simply switch focus to it.
