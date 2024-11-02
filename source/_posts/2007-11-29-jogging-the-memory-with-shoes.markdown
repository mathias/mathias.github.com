---
layout: post
title: "Jogging the memory with Shoes"
date: 2007-11-29 12:09
redirect_from:
  - /blog/2007/11/29/jogging-the-memory-with-shoes/
---

(This post is part of my [blog archiving project](/about#old-posts). This post appeared on
[http://bytecodex.wordpress.com/][] on November 29, 2007.)

Today, I wanted to share my latest little one-night coding project. But
first, a little back story. I’ve been looking for a new Mac OS X GUI
text editor for the past couple of days because TextMate has once again
passed its free 30 day period for me. I don’t mind editing text purely
with keyboard commands in a terminal window, but sometimes it’s nice to
have a mouse and menus when you’re working with chunks of code. I’ve
read studies from Apple that while using only keyboard shortcuts seems
faster, in truth the mouse is quicker at the same task.

On the command line, I’m more likely to use vi than emacs, although I
know my way around both. So when I found [MacVim][], an “experimental”
Cocoa interface to vim, I knew I’d found my new editor on the Mac. I’ve
already tried all the free editors that worked on Mac OS X in the past,
including jEdit (too slow), Eclipse (really an IDE, and even slower),
Komodo/Smultron/etc., and even most of the for-pay editors (BBEdit,
aforementioned TextMate, and SubEthaEdit). MacVim really takes the cake,
as the vim core understands far more languages & markups than TextMate’s
bundles; it’s as fast as one can perceive a program to be; and it adds a
GUI (gooey!) layer of goodness on top, including tabs, mouse-based
copy/paste/cursor positioning, and a full-screen editing mode to
eliminate distractions.

I’ve also been playing with [Shoes][], a framework for making GUI apps
in Ruby. Shoes is the brainchild of Ruby super-hacker WhyTheLuckyStiff,
and I wouldn’t have heard about it without [Phil Crissman][]‘s
[twittering][] about his interest in using it.

The super simple syntax in Shoes lets you lay out GUI components like
elements in a web page, and graphics/animations are easily added. Most
apps are as simple as:

    Shoes.app do
      stack :margin => 10 do
        para "Chunky Bacon!"
      end
    end

But the real frustration is in the lack of documentation. There are a
handle of sample apps on the project’s SVN web repo and roughly 4
tutorials. The full documentation is currently being printed up as a
real-deal book by WhyTheLuckyStiff, and I didn’t feel coughing up the
$8+shipping to get a copy. (& knowing Why, I wouldn’t understand
anything in it anyways). So, I’ve been playing around and doing a lot of
trial and error based on the sample apps to figure out functionality.
Luckily, Quicksilver makes the run-test-repeat loop very tight. (For the
interested, CMD-Space into QS, type “Shoes” TAB TAB, first three letters
of my Shoes’ script’s filename, ENTER & it’s running. Having to launch
the .app rather than calling from the CLI is a problem unique to the OSX
version of Shoes. On Linux it’d be $ ./shoes App.rb )

My first little app was nothing more than adding file saving and opening
functionality to the sample edit.rb script, added color and formatting,
buttons, etc. and then modified it to catch a few more commands given
via keypress. Nothing too fancy, but it was a good way to figure out the
majority of Shoes’ internals. While it was a fun idea to entertain,
Shoes is not the ideal platform to develop a text editor in. Luckily, I
don’t have to, as I’ve got MacVim.

But maybe I could use a little tool to help me remember all the various
vi commands?

![Shoes cheatsheet widget][]

Introducing my cheatsheet widget for vim in Ruby Shoes. It’s based off
the heavy cardstock “vi Quick Reference” sheet that everyone in my
vi-specific CSCI classes was issued (I imagine there’s an emacs
equivalent for classes where emacs is encouraged). Believe it or not,
the longest part of creating this app in Shoes was typing in all the
command hints off the physical copy & thinking up multiple ways to implement
classes containing the data in Ruby. The reinforcement of forgotten vi command
skills in developing this widget in MacVim should be obvious.

Using the drop-down allows you to access such diverse topics as:

![shoes2.jpg][]

It really does make a nice little app to have running off to the side,
and I’d argue that it was far simpler to create than an Adobe AIR app or
Apple Dashboard widget would have been with the same functionality.

Tomorrow, if suitably motivated I may extend it to read in any number of
.yml files containing ‘cheat sheet’ definitions, and add definitions
from any number of the PDF cheatsheets I’ve accumulated over the years
and never bothered to print out (glancing in my PDF dir, I spy PHP,
MySQL, sqlite3, microformats, and even, yes, Ruby & Ruby on Rails
cheatsheets in there). Using graphics I’ll implement a simple ‘tab’
interface across the top and clean it up so it looks slick. (Red
background when you click on the Rails tab? With little Ruby icon
hovering there? Yes!)

![shoes3-1.jpg][]

Coding in Ruby is so much fun, it makes trivial things like this
interesting, and Shoes follows in that tradition.

Until next time, happy hacking.

  [http://bytecodex.wordpress.com/]: http://bytecodex.wordpress.com/2007/11/29/jogging-the-memory-with-shoes/
  [MacVim]: http://code.google.com/p/macvim/
  [Shoes]: http://code.whytheluckystiff.net/shoes/
  [Phil Crissman]: http://philcrissman.com/
  [twittering]: http://twitter.com/philcrissman
  [Shoes cheatsheet widget]: /images/shoes-cheatsheet.png
  [shoes2.jpg]: /images/shoes-cheatsheet-2.jpg
  [shoes3-1.jpg]: /images/shoes-vim-cheatsheet.jpg
