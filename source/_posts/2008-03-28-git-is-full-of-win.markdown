---
layout: post
title: "Git is full of win"
date: 2008-03-28
redirect_from:
  - /blog/2008/03/28/git-is-full-of-win/
---

(This post is part of my blog archiving project. This post appeared on
[bytecodex.wordpress.com](http://bytecodex.wordpress.com/2008/03/23/git-is-full-of-win/)
on March 23, 2008.)

The blogosphere seems to be blowing up with regards to the SCM suite
[git](https://git-scm.com). At least, the blogosphere I frequent.

git is an open source project started by Linus Torvalds and currently
maintained by Junio Hamano, intended to replace the proprietary
[BitKeeper](http://en.wikipedia.org/wiki/BitKeeper "Wikipedia - BitKeeper")
system that the Linux kernel project used. Like
[Monotone](http://www.monotone.ca/ "http://www.monotone.ca/") and
[Mercurial](http://www.selenic.com/mercurial/wiki/ "http://www.selenic.com/mercurial/wiki/"),
git is a modern decentralized revision control system that makes use of
cryptography. The ‘repo’ doesn’t live on one server, instead every local
copy on a developer’s machine is a full repo, with full version history.
Developers initially copy the repo from somewhere (also known as
branching or creating a clone) and make changes locally, commiting
changes to their local repo as they code.

The process of combining two branched repos in SCM is known as merging.
When developers are ready to share their changes, they can ‘merge’ their
work back into other developers’ trees, or others could pull down
changes from the developer’s local repo and work from there. Merging was
previously a time-consuming and frustrating task with other SCM tools,
but git needed to be able to merge the repos of the Linux kernel
developers fast. In fact, git makes it so much easier than previous SCM
tools to branch and merge both local and remote repos that developers
can keep several branches around locally for various changes to live in.

The best
[image I
found](http://www.mcl.iis.u-tokyo.ac.jp/eng_version/index.html)
to represent this style of passing around changes has nothing to do with
version control, but gives a good idea if you think of ‘messages’ as the
changes:

![adhoc.jpg](/images/2008-03-28/adhoc.jpg)

Because all the cool developers hack on laptops now.

Usually while riding on bullet trains.

Subversion & CVS, on the other hand, use a centralized server that all
changes must be downloaded from and uploaded to; making concurrent work
possible. But a centralized server may be restrictive if a development
team is scattered across the globe (as in the Linux kernel team & most
open source projects) rather than scattered across the cube farm. (As a
side note: git does allow for public repo servers, but that is a whole
‘nother topic.)

Best of all, **git is fast**. [Faster than your
filesystem](http://www.advogato.org/person/apenwarr/diary/371.html "Blog for apenwarr - Git is the next Unix"),
in some cases. You can throw data in its repo & **10 years later it
ensures you get the exact same file out**, due to cryptographic hash
checking. SCM tools of years past couldn’t vouch for the integrity of
your files, in fact checking in files was more likely to corrupt files
at some future point, rather than protect them.

I’m not going to go into all the features of git or why it’s faster,
there’s [plenty of
resources](http://robsanheim.com/2008/02/22/learn-git-10-different-ways/ "Panasonic Youth - Learn Git 10 Different Ways ") already.
If you’ve used Subversion (svn) in the past, then [this
tutorial](http://git.or.cz/course/svn.html "Git -SVN Crash Course") is
probably your best bet.

Since this turned into more of an overview of git rather than covering
the two topics I had in mind when I started, look forward to two more
posts this week: one on [GitHub](http://github.com/), a git repository
hosting service, and [git-wiki](http://atonie.org/2008/02/git-wiki), a
wiki intended for personal use that checks its changes into a local git
repo.
