---
layout: post
title: ! 'Git & Github: A Beginner''s Guide'
published: true
redirect_from:
  - /blog/2010/12/10/git-github-a-beginner-s-guide/
---

 Let me start off by saying that this blog post isn't going to introduce you to the intricacies of git. There is certainly a lot to be learned and a lot that I could write about branching, managing git servers, and any number of the git commands and ways to use them. I've linked to more resources where you can learn all of that at the bottom of this post.

Instead, I'm going to focus on the beginner user, maybe someone that has never contributed to open source but wants to learn and wants to help out. They're not interested in learning the in's and out's of every single command. They just want to _get stuff done_.

It's likely that a person would run into git for the first time by visiting [Github](https://github.com). There are a lot of big, popular open source projects hosted there. Too many to list here, in fact, but here's a quick teaser: jQuery, scriptaculous, yui3, prototype, and mootools are all on Github. So are Ruby on Rails, Symfony, Django, web.py, and many other web app frameworks. The list goes on and on.

But why is Github so popular? It certainly has a nice design. But design alone doesn't necessarily attract developers by the hundreds; most of them still use the arcane commandline with bitmapped fonts, after all.

I'll put forward that **Github is popular with developers because it optimizes for the things they need to do**, without getting in the way. And because it's **fun**. There's very little barrier of entry for a developer to contribute back to open source, or upload new code, or even find projects that are interesting to them. It takes all the best features of git (which we'll get to in a minute) and smooths out all the rough, annoying edges of setting up a server, handling SSH key authentication, and tracking URLs to reference.

Let's assume our beginner has stumbled upon [Pete Prodoehl](http://rasterweb.net/raster/)'s Heard project, which lets you mirror your [Last.fm](http://last.fm) scrobbles and host it in a decent way outside of Last.fm. The user wants to use it to back up their Last.fm, too. They likely came across Heard in [Pete's blog](http://rasterweb.net/raster/2010/07/22/heard-a-last-fm-mirror/). The blog post contains a link to the [Heard Github repo](https://github.com/raster/Heard).

This is the first time the user has been to Github, so they don't quite know how it works. If the user hovers over the Watch or Fork buttons, they will be instructed to sign in. They might just click the big Download button and never come back, but let's assume this person wants to contribute back. They know they want to add a feature to Heard so that it draws [gRaphaël graphs](http://g.raphaeljs.com/) of their listening history, because they think graphs are pretty cool and gRaphaël draws very beautiful graphs.

The user then creates an account on Github, since they don't have one and it's required to click those Watch or Fork buttons. They go back to Pete's Heard project on Github and click Watch. The text changes from Watch to Unwatch but they don't notice anything immediately. Watch is a way to subscribe to repo changes in the Dashboard of Github, but our user doesn't know that yet. Looking for more immediate satisfaction from clicking buttons, our user clicks Fork. And then something magical happens. (Parents please make your children leave the room during this part of the program.)

The user is now in their own copy of Heard. Github has forked the open source project, a task which once took Herculean strength and immense popularity to pull off in the dark days of [Sourceforge](http://sourceforge.net/)! The user realizes this forked project is their very own kingdom to do with as they please. And the user, motivated by their hunger for pretty graphs and encouraged by the fact that Github is hosting their fork for free, is ready to jump into coding. (All open source projects get free hosting on Github, and open source does not count against your paid account's number of repositories.)

The first step Github gives after setting up your account is to install git. We'll leave it up the to the reader to track down and install the latest version of git (at the time of this writing, v1.7.3.3) from [http://git-scm.com/](http://git-scm.com/) for their particular operating system.Once our daring, brave fictional hero gets git compiled and installed, Github instructs them to generate an SSH key and enter it into their [Account Settings](https://github.com/account) on Github.

**Sidenote: What are SSH keys and why do I need them?**

SSH is a secure communications method that uses public/private key encryption. Explaining public/private key encryption with Bob, Alice and the gang is beyond the scope of this blog post, but in short, it works like this: You generate two keys, a public and a private key. A key is just a bunch of characters in a text file, but it's used as a very strong [cryptographic key](http://en.wikipedia.org/w/index.php?title=Key_(cryptography)).The public and private key are linked in such a way that you can mathematically prove data came from the person holding the private key.

The private key must be kept private! No one but you should ever possess it! When you cryptography "sign" a file, text, or other data with your private key, another party can verify that you (and only you) could have sent that data, by using your public key. You can also guarantee the identity of a server you're communicating with, because their public key allows you to verify data was signed by their private key. Make sense?

So when you put your public key into Github, it can verify that any data sent to it claiming to be you is actually from you (and signed by your private key). It's much more complicated than this, but that's the idea.

For more information on OpenSSH, SSH keys, and the like, refer to the [OpenSSH FAQ](http://openssh.com/faq.html).

**Back to Github:**

Our user runs the

`ssh-keygen`

command in their shell, hits enter for the defaults, and generates some files that live in `/home/[username]/.ssh` in Linux/BSD or `/Users/[username]/.ssh` if you're on Mac OSX. If you're still on Windows, it'll be in Cygwin somewhere, likely. Sorry. Can't help you there.

One file is called `id_rsa` and the other is `id_rsa.pub`. The file with the .pub extension is, naturally, the public key. That's the one that you want to copy into Github's Account Settings page. Once you enter a public key (again, make sure it isn't the private key!) into Github, it will know who you are when you communicate with Github using the git commands. The great thing about this is, every time we communicate with the server, we don't have to type a password. Isn't that cool?

At this point our beginner hasn't actually gotten any files, made any changes, or asked Pete nicely to accept his changes. That may seem like all this effort was a waste, but in practice it is fairly quick and once you've done it once (and setup a Github account) you're well on your way to doing all those things. Git also prefers to have your name and email address to identify changes as coming from you, and Github helpfully provides the commands for those when setting up a new account.

The user is ready to work. At the top of their fork of the Heard project, Github gives the user a link says it is read+write. Which probably means that by using it somehow, we can write our changes back to Github and get one step closer to getting those changes back to Pete. Github even helpfully offers to copy the link for you.

Our user dives into the [gitref.org](http://gitref.org/) page and discovers what they are supposed to do with this URL ending in .git: They must use the git clone command to clone it from Github down to wherever they are in the shell, like so:

```
$ git clone git@github.com:mathias-presentation/Heard.git
Cloning into Heard...
remote: Counting objects: 22, done.
remote: Compressing objects: 100% (22/22), done.
remote: Total 22 (delta 7), reused 0 (delta 0)
Unpacking objects: 100% (22/22), done.
```

If the user's SSH key was right, this will work. If not, they'll have to go back and fix it. Looks like it worked, though, so we'll move on.

The git clone command has created a directory named Heard in the user's home directory. There's also a hidden .git directory in there, but that's where git keeps its affairs in order, and for the purposes of this post, it can be ignored. The nice thing about git is that the .git/ directory is the only place it adds something to your project, unlike Subversion, which puts a .svn directory in every directory.

The user is now ready to use git, with an eye towards contributing his changes back to Pete as fast as possible.

**Git Basics**

Our user makes some basic changes to the PHP files in their local Heard directory. They reason that if git keeps tracks of versions of files, it will need to create a new version containing these changes. Git tracks changes on an object level, not a file or project/directory level. That means it is really smart about where you changed something. See some of the reference material for a full explanation of how git understands changes. For our purposes, the beginner finds the

`git commit`

command. The documentation says that the commit command is used to take a snapshot of the code in the current state. That sounds perfect. But typing the command yields:

```
$ git commit
# On branch master
# Changed but not updated:
#   (use "git add ..." to update what will be committed)
#   (use "git checkout -- ..." to discard changes in working directory)
#
#        modified:   config.php
#        modified:   init.php
#        modified:   tracks.php
#
no changes added to commit (use "git add" and/or "git commit -a")
```

Nothing happened, as indicated by the message "no changes added to commit." Git has helpfully suggested some ways to commit at the bottom there. The first is to use the

`git add`

command, which sounds like a way to add files to a commit. The other is to pass in the -a argument to git commit, like this:

`git commit -a`

The -a is for all, so when we tell git to git commit -a, we're telling it to commit everything that changed, all at once. The user types that in and is dropped into.. a text editor?

This step can be a little confusing for new users. In fact, that this is default behavior is, in my opinion, a huge roadblock to people to get up and running with git. On Mac OSX or Linux, this is likely to be vim, which is not the most user-friendly to new users.

What is the text editor for? Git is asking for the user to write a commit message, that is, a description of what changed for the official history of this project. For something more user-friendly to write this commit message in, I suggest you type this arcane incantation from the wizards of old:

`git config core.editor "nano"`

The meaning of this spell is lost to the ages, but the nice thing is, it will drop you into the much more user-friendly nano editor, which list the CTRL- characters to save, quit, etc. along the bottom of the terminal.

A good commit message will help later when trying to find what changed over the course of time. Git is already tracking which files changed and what changed in them, so the message is usually written at a more abstract level that says **what** the user was doing and thinking. There's plenty of good resources out there on the web about writing good commit messages, and even more about opinions about what should and shouldn't be in a commit message.

This is where I want to break the narrative a little to explain the rest of the commands that our fictional beginner will need to contribute back to Pete's Heard project. Think of it as a [blog post montage](http://www.youtube.com/watch?v=JU9Uwhjlog8) of lots of coding getting done.

The first is simply another argument to add to the git commit command so that we don't get dropped into a text editor to write our commit message. Usually, commit messages are only one line, so it makes sense to write the commit message right there on the command line:

```
$ git commit -am "Added the gRaphael library to be loaded, but haven't integrated it yet."
[master 1a4014f] Added the gRaphael library to be loaded, but haven't integrated it yet.
 3 files changed, 3 insertions(+), 3 deletions(-)
```

As you can see, that worked, and it accepted our commit message right there on the command line. Notice that the commit message is wrapped in double quotes: " " This is because the shell will try to interpret words on their own as commands, and we don't want that. So, to be safe, we wrap the whole thing in double quotes, so that the shell knows that this is a string to pass into the git command and not something to try and execute.

What else does the output from git commit tell us? Well, we committed all three files at once. In other version control systems, you must commit all changes to files at once. This can get annoying. In git, you can choose which files you want to add to any given commit, and leave out anything else that changed. To do that, we use the git add command.

```
[do some work]
$ git add config.php
$ git add init.php
```

You'll notice there's no output from these commands. That's because nothing has changed yet. Those changes still need to be committed. It would probably be helpful at this point to have a look at what changed and what didn't. For that, we use the git status command.

```
$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 1 commit.
#
# Changes to be committed:
#   (use "git reset HEAD ..." to unstage)
#
#        modified:   config.php
#        modified:   init.php
#
# Changed but not updated:
#   (use "git add ..." to update what will be committed)
#   (use "git checkout -- ..." to discard changes in working directory)
#
#        modified:   tracks.php
#
```

As you can probably see, we're not going to commit all the changes like we did in the first commit. We're only going to commit the changes in the config.php and init.php files this time around, while tracks.php will be left out of the commit. Git status is a very useful command, and you will probably use it a lot to figure out the current state of your project and to see what should and shouldn't be in a commit. Since we don't want to commit all changes this time, we leave off the -a argument but keep the -m so we can specify a commit message:

```
$ git commit -m "A little refactoring."
[master 6dd5c59] A little refactoring.
 2 files changed, 2 insertions(+), 2 deletions(-)
$ git status
# On branch master
# Your branch is ahead of 'origin/master' by 2 commits.
#
# Changed but not updated:
#   (use "git add ..." to update what will be committed)
#   (use "git checkout -- ..." to discard changes in working directory)
#
#        modified:   tracks.php
#
no changes added to commit (use "git add" and/or "git commit -a")
```

Notice that the changes in tracks.php are still waiting for us when we perform another git status.

Git log is a command used to see the history of a project.

```
$ git log
commit e47cd6eb917d2a68ec6d1197a38faa1a1ff5e564
Author: Matt Gauger
Date:   Thu Dec 9 14:27:04 2010 -0600

    Some other places where it's nice to have newlines.

commit fb2cc2b00bfd797cca355a4215b2c289e281e040
Author: Matt Gauger
Date:   Thu Dec 9 14:26:23 2010 -0600

    Add a newline here.

commit 4cce3dff9c8d03b7db1710f7addaa7d556921a44
Author: raster
Date:   Sun Nov 14 11:38:50 2010 -0600

    Minor changes, still learning git

[truncated for length]
```

At this point you may be asking, how does our user upload their changes back to Github?

The command required is: 

`$ git push`

And in its default form, it knows what to push and where: It defaults to Github when you use the git clone command as above. A more complicated form of git push will allow you to choose the branch and the server to push to, but for our beginner user that is only using the master branch and Github server, it is unnecessary to understand.

Similarly, to get changes from the server, use the command:

`$ git fetch`

This is, again, some default behavior that knows to go talk to the Github server. It will pull down changes from the user's repo on Github, in this default manner, and it is important to note that **this won't include the changes made by other Github users**. This part can initially be confusing to people who are looking to keep up with a project's main development or other developer's contributions, and Github's documentation explains this stuff (and it is managed largely through the Github website) so I'll leave it beyond the scope of this blog post.

The git fetch command is useful if you have two computers with SSH keys in Github, for example, and you commit and push from your desktop, but want to grab your most recent changes on your laptop.

The other question you may be asking yourself at this point is: What happens if I screw up? What if you accidentally delete a file from your project, or you save something you didn't mean to save. In this case, you can restore the project to the state of the last commit. Git is, after all, storing all the states of the project, so you can roll it backwards as necessary. The command to reset a project back to its previously committed state is:

`$ git reset --hard HEAD`

There's a lot going on here to point out. The git reset part is obviously the command that we use to reset a project to a previous state. The state we're telling to to go back to is called HEAD, which is just a placeholder name for the last commit. There's lots of these placeholder names in git, and it's nice to learn the common ones. For the purposes of this blog post, we can ignore the --hard, and refer you to the reference materials and "man git-reset" on your shell for further explanation.

You want to **be careful with git reset**, obviously. It will reset all the files in your project to the state they were in at the last commit. So all changes since the last commit will go away. This isn't always ideal. You could lose a lot of work this way. If you want to only reset one file, this is the way that I do it, and I imagine there are other ways in the very many different git commands:

```
$ git checkout -- init.php
$ git checkout HEAD init.php
```

In this case we're taking the state of init.php back to the last commit, which again, is referenced with the placeholder name HEAD. 

That's the most common commands that this beginner user will encounter and have to grasp in using Github and git. So now what? Well, remember that our user had the end goal of contributing back to Pete Prodoehl's Heard project. The way to do is to go back to our user's fork of Heard on Github, and use the Pull Request button. [[posterous-content:saBGwBFliwBpFsmACHAI]]

Which is highlighted in blue above.

By submitting a Pull Request back to Pete for the changes the user has made, Pete can choose which commits to pull into his version of Heard, which is basically the official repo for the project at this time. By getting Pete to accept a Pull Request, our user has contributed back to Heard, which was the user's initial goal. It wasn't the easiest road to contributing back, but once developers learn these skills and they have set up both git and Github to their liking, it is actually quite fast, fun, and powerful to use Github to contribute to open source.

Thanks for reading! Please leave comments on places where this could be improved or any other thoughts you have.

**Slides from my talk:**

**[Matt Gauger - Git & Github web414 December 2010](http://www.slideshare.net/mathiasx/matt-gauger-git-github-web414-december-2010 "Matt Gauger - Git & Github web414 December 2010")** <object height="355" width="425"><param name="movie" value="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=gitgithubweb414december9th2010-101210120907-phpapp02&amp;stripped_title=matt-gauger-git-github-web414-december-2010&amp;userName=mathiasx"> <param name="allowFullScreen" value="true"> <param name="allowScriptAccess" value="always"><embed src="http://static.slidesharecdn.com/swf/ssplayer2.swf?doc=gitgithubweb414december9th2010-101210120907-phpapp02&amp;stripped_title=matt-gauger-git-github-web414-december-2010&amp;userName=mathiasx" type="application/x-shockwave-flash" height="355" width="425"></object>

View more presentations from [mathiasx](http://www.slideshare.net/mathiasx).

**Further reading:**

*   Github has great documentation online at [help.github.com](http://help.github.com/). I highly suggest you start there.
*   Github will point you in the direction of the [gitref.org](http://gitref.org/) page for a quick overview of Git.
*   Scott Chacon released his book, [Pro Git](http://progit.org/book/), online for free. It is also available from Apress on Amazon: [Pro Git](http://www.amazon.com/gp/product/1430218339)![](http://www.assoc-amazon.com/e/ir?t=httpmattgauco-20&l=as2&o=1&a=1430218339). (~~Full disclosure: Amazon Associates link.~~ [Author's note as of 2015-12-19: I don't have Amazon Affiliates/Associates links on my blog anymore and haven't for awhile.])
*   The [Pro Git blog](http://progit.org/blog.html) is a good place to continue to pick up Git tricks and tips as you learn.
*   It hasn't been updated in a long time, but the [git ready](http://www.gitready.com/) blog has taught me many tricks that I use with git.

**All other resources mentioned:**

*   [http://git-scm.com/](http://git-scm.com/)
*   [https://github.com](https://github.com)
*   [http://rasterweb.net/raster/](http://rasterweb.net/raster/)
*   [https://github.com/raster/Heard](https://github.com/raster/Heard)
*   [http://g.raphaeljs.com/](http://g.raphaeljs.com/)
*   [http://openssh.com/faq.html](http://openssh.com/faq.html)
*   [http://en.wikipedia.org/w/index.php?title=Key_(cryptography)](http://en.wikipedia.org/w/index.php?title=Key_(cryptography))
