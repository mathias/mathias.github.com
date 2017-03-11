---
layout: post
title: "Mining for computation on the beach"
date: 2016-09-30 08:23
---

The introduction to [Writing GNU Emacs Extensions](https://www.goodreads.com/book/show/1639039.Writing_GNU_Emacs_Extensions) introduces Emacs by talking about plumbers. "Plumbers?" you might think. The thing it wants us to think about is whether plumbers make their own tools.

Plumbers buy pipes and fittings in standardized sizes. They depend on the [International Building Code](https://en.wikipedia.org/wiki/International_Building_Code) and local building codes to tell them what is safe and necessary. They use tools made for the tasks they'll likely need to do. As the book says, “a plumber doesn’t tinker with his wrench.”

I imagine that there are plumbers do build their own little jigs to hold pipes together, or to trace a pattern before cutting a hole. These solutions come from experience from past work and knowing the current problem. The book might fall a little flat here -- plumbers can solve problems by making things. But what about their standard tools?

Again, from the book, “the plumber would tinker with their tools, if they knew how.”

Are most plumbers like the programmer that uses Emacs? Likely not. Because, the book says, Emacs is a tool that programmers can use to build tools. Emacs is a kind of [ouroboros](https://en.wikipedia.org/wiki/Ouroboros): software that builds software, software that can change itself.

A better example of makers making tools is the machinist in their machine shop. Machinists make jigs and holders all the time. And they must, or they'd never be able to clamp an odd-shaped piece to work on it. But the abilities of machinist goes beyond jigs and holders.

The tools in a machine shop are sufficient to create more tools. With a lathe and a vertical mill, one could create the hard parts of any of the machine tools in the shop. Granted, most machinists would not consider creating another vertical mill from scratch. The labor involved would suggest that one should buy one from a manufacturer. A manufacturer builds tools at scale. Such tools come at a reasonable cost relative to the labor to create a mill yourself. But the ability of a machinist to recreate everything from scratch is there, if need be.

Software is much cheaper to build. The ease of modifying Emacs causes people to build all sorts of tools with it. Those tools go beyond editing of source files. There's IRC clients, web browsers, and more. There's even a system called [TRAMP](https://www.emacswiki.org/emacs/TrampMode) that allows you to edit a file over FTP, SFTP, NTFS, and more. TRAMP makes them all appear to be a local buffer in Emacs.

If the machinist wanted to recreate their machine shop from scratch, what kind of reference would they need for that?

There exists a shelf full of books that sets out to create a machine shop from scratch -- the [Gingery books series 'Build Your Own Metal Working Shop From Scrap'](http://gingerybookstore.com/). These colorful books haunt the book cases of Makerspaces and home shops. The first book starts with sand on the beach and charcoal made from trees inland. With this start, you can cast aluminum and zinc parts. Take some scrap with some common parts and the second book will teach you how to make a metal lathe. This continues for seven books, until you have built your own home machine shop from scrap and sand on the beach. With these books, you are able to build more tools and replace anything worn out or broken.

Having these books on your shelf might be interesting if you like to make physical things. Owning them might be part of your expanded understanding of how the world works.

And of course, these books might be a good idea to have on your shelf for any zombie apocalypse that might befall us.  (Whether you'll need a machine shop in the apocalypse is a worthwhile question. Antibiotics and growing food might be more important. As an aside, what other references would we want on our shelf to recreate civilization?)

For computation, there are several books that set out to teach from the level of "sand on the beach." What might that look like?

Start with relays, simple electromagnetic switches. A relay can only be on or off. The binary state means that we can represent numbers by counting in binary. We can treat on or off like true and false. With enough switches, we can create logic gates for all the types of logic operations. Then, we can combine these gates into more complex mechanisms like adders or a full 8-bit CPU. Lastly, we can begin to understand how the instruction set works in a CPU to create software. That's the approach in [Code: The Hidden Language of Computer Hardware and Software](https://www.goodreads.com/book/show/13020367-code). I recommend this book highly. The difficulty curve of each chapter is just right to keep you engaged through the whole book. I only wish I'd read it a decade earlier!

[Nand2Tetris](http://nand2tetris.org/) is a free book and online course. This approach uses hardware emulation rather than relays as a building block. The book starts with basic gates and works up to a “general-purpose computer system.” Or rather, something we can build a Tetris clone on. Following along in the hardware emulation software is a good way to grok the details. Hardware emulation avoids most of the frustrations of my undergraduate digital logic course. Namely, having to build a test harness to ensure the quad NAND gates weren't faulty.

Computer science is about the theory of computation. If you'd like to learn about that, then [Understanding Computation](https://www.goodreads.com/book/show/15842786-understanding-computation) by Tom Stuart is next on the list. This book uses Ruby, which makes it more approachable than more academic books. This book helps to fill in some of the gaps in my understanding from a career in mostly-web programming.

That covers the hardware and the computational theory that goes into programming. But what about programming itself? What if we wanted to start with the basics of programming? To answer this, we'd want books that teach us to how go from assembly to something higher-level. We'd want to know how what issues one might face when stepping up a level from machine code.

I'm afraid I don't have much to suggest beyond the classics on programming here. Stick with favorites like [The C Programming Language](https://www.goodreads.com/book/show/515601.The_C_Programming_Language) by Kernighan and Ritchie, and you can't go wrong.

If you want an alternative world view on solving problems, read [Programming A Problem Oriented Language: Forth - how the internals work](https://www.goodreads.com/book/show/23165738-programming-a-problem-oriented-language) by Charles H. Moore and wrap your head around Forth.

Another book in this vein might be [Build Your Own Lisp](http://www.buildyourownlisp.com/) if you've never completed such a feat. Or look to [mal](https://github.com/kanaka/mal) and its wealth of implementations to understand how to build a Lisp. Implementing lambda calculus interpreters and Lisp-like languages is a good pastime, and one that I'd like to practice more.

At the level of operating systems, we find more valuable resources. [Lions' Commentary on UNIX](https://www.goodreads.com/book/show/337375.Lions_Commentary_on_UNIX) provides the UNIX source code with commentary. Suppressed by AT&T long ago for revealing their trade secrets, it's now easy to get a copy of on Amazon.

Imagine starting from scratch and creating an operating system. And, creating a language to go with that operating system. That's the path taken in [Project Oberon](https://www.goodreads.com/book/show/116985.Project_Oberon) by Niklaus Wirth. This book will help you to think about different facets of a problem and how to solve it from all sides. You might want to abandon what you take for granted in computing. It’s an alternative-computing rabbit hole that will make you wonder why current computing is so mundane. (This, along with learning about Lisp machines, might make you interested in reinventing the wheel. Fair warning.)

At this point, we're diverging from covering the basics and into realms that I enjoy thinking about. If you've come this far and you really must push your understanding past traditional Turing machines, then I have one book to recommend to you. It's much more expensive than when I bought it, and is only available used. [The Architecture of Symbolic Computers](https://www.goodreads.com/book/show/6033620-the-architecture-of-symbolic-computers) by Kogge is a tome on symbolic and logical computing. If you've taken the rabbit hole of Oberon and have made time to learn about Lisp machines, this book is a real treat. Symbolic and logic computing are part of a complete understanding of computation.

Stepping back from our tangent, you might ask, "What does this all have to do with Emacs?" Well, I'd put [Writing GNU Emacs Extensions](https://www.goodreads.com/book/show/1639039.Writing_GNU_Emacs_Extensions) on the list, as the book about building tools. It won't cover the other tools you'll likely need in computing: how to build a compiler, how to write Makefiles, and so on. But if you want to build tools, it is good to have a deep understanding of a tool for building tools. Emacs is a good platform to tinker, and it can be that workshop from which your other tools emerge. Learning Emacs, and how to build things in Emacs, has been rewarding to me and my time invested.

Even now, hackers are rebuilding Emacs in Rust with a project called [remacs](https://github.com/Wilfred/remacs). The ouroboros Emacs is helping to rebuild itself in a new language.

You need to know your tools, and know where they came from, to know them well. This list is a good start on a deep knowledge of computing. Books help us to understand what came before, and to think about where we can go.

I've set up an [`apocalyptic-computing` bookshelf on Goodreads](https://www.goodreads.com/review/list/2450080-mathiasx?shelf=apocalyptic-computing) to track these books. The name suggests that this is the list of books I'd bring with me to rebuild society, should we need it. With a list like this can we go "mining for computation on the beach" and hope to know enough to start from scratch.

What books would be on your `apocalyptic-computing` shelf? [Let me know](mailto:contact@mattgauger.com), or set up your own Goodreads shelf and send it to me!

## Notes

1. If you want to learn Emacs itself before you dive into Writing GNU Extensions, then I recommend [Mastering Emacs](https://www.masteringemacs.org/) and the [Using Emacs](http://cestlaz.github.io/stories/emacs/) video series.
1. [Org mode](http://orgmode.org/) is perhaps the most important tool I've learned in Emacs, and now powers large parts of my life.
