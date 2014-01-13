---
layout: post
title: "A theory of compound intelligence gain"
date: 2014-01-12 14:02
---

Note that this is probably not enough to call a theory. It's an idea, at most.

I'm currently reading the book [Race Against the Machine](http://www.amazon.com/gp/product/0984725113), which describes how increasing levels of automation by technology are related to capital and labor. But this post isn't about that book. It simply triggered me to think about my motivations for my current side projects, and how I might explain to others why exactly I think that my current side projects are so important.

While *Race Against the Machine* describes technological progress as a force that leaves behind skilled workers who no longer have relevant skills, my thinking is on intelligence augmentation, and how I can use my own knowledge and programming skills to build tools that increase my own effectiveness and ability to perform my job. Namely, how can I write software that improves my cognition and memory such that I am better at writing software, and gain other benefits from having increased cognition and memory?

Douglas Engelbart [wrote extensively](http://www.dougengelbart.org/pubs/augment-3906.html) about augmenting intelligence, primarily with improving workflows and then with computer software. I've previously [quoted him](http://blog.mattgauger.com/blog/2013/03/17/by-augmenting-human-intellect/) on this blog. I feel that part of that quote bears repeating here:

<blockquote>
By "augmenting human intellect" we mean increasing the capability of a man to approach a complex problem situation, to gain comprehension to suit his particular needs, and to derive solutions to problems.
<footer>
<strong>Douglas C. Engelbart</strong>
&ndash;
<cite><a href="http://www.dougengelbart.org/pubs/augment-3906.html">Augmenting Human Intellect: A Conceptual Framework </a></cite>
</blockquote>

Of course, Engelbart was writing about this in 1962 -- well before every home had a personal computer and everyone had a powerful supercomputer in their pocket. For a modern overview of Engelbart's framework, see [The Design of Artifacts for Augmenting Intellect](http://fluid.media.mit.edu/sites/default/files/The%20Design%20of%20Artifacts%20for%20Augmenting%20Intellect.pdf).

My earliest encounters with concepts of intelligence augmentation most likely come from science fiction. One character that has inspired a lot of my work (and that I've probably told you a lot about if we've discussed this project in person) is Manfred Macx from Charles Stross's [Accelerando](http://www.antipope.org/charlie/blog-static/fiction/accelerando/accelerando.html). Macx is described in the early parts of the book as having a wearable computer that acts as his *exocortex*. The idea of an exocortex being that some part of his memory, thinking, and information processing lives outside of his head and on the wearable computer. Similarly, the exocortex can help act as a gate to his attention, which is one of our limited resources.

If you think about it, just as [we are all cyborgs now](http://www.ted.com/talks/amber_case_we_are_all_cyborgs_now.html) by virtue of the technology we use every day, we are also all on our way to having exocortexes. Many of us use Gmail filters to protect our attention spans from email we receive but don't always need to read. Or we use Google search to add on to our existing memory, perhaps to remember some long-forgotten fact that we only have an inkling of.

I've had Manfred Macx's exocortex (and other flavors of science fiction's wearable computers and augmented intelligences) kicking around in my head for years. Gmail tells me that I was trying to plan the architecture for such a thing as far back as 2006. It's taken a lot of thinking and further learning in my career to even get to the point where I felt ready to tackle such a project.

What I am setting out to build is an exocortex of my own design, under my own control. Not something that is handed to me by Google in bits and pieces. And to do so, it turns out, requires a lot of research and learning. There's tons of research on the topics of proactive autonomous agents, text classification, and wearable computing that I have been reading up on. Just to build the first phase of my project, I have been learning all of the following:

* [core.logic](https://github.com/clojure/core.logic) (which is based on Prolog, so I'm learning some Prolog now, too)
* [core.async](https://github.com/clojure/core.async) (Clojure's implementation of C.A.R. Hoare's [Communicating Sequential Processes](http://www.amazon.com/Communicating-Sequential-Processes-International-Computing/dp/0131532715/), which is also how Go's goroutines work)
* [Cascalog](http://cascalog.org/) and [Hadoop](http://hadoop.apache.org/), to do my distributed computing tasks
* [Datomic](http://www.datomic.com/) & Datalog (a subset of Prolog for querying Datomic), to store knowledge in a historical fashion that makes sense for a persistent, lifelong knowledge system
* Topic clustering, text classification, and other natural language processing approaches
* Data mining, and in particular, streaming data mining of large datasets on Hadoop clusters, by reading the Stanford textbook [Mining of Massive Datasets](http://infolab.stanford.edu/~ullman/mmds.html)
* Generally learning Clojure and ClojureScript better
* and probably more that I am forgetting to mention

Of course, if I look at that list, I can be fairly certain that this project is already paying off. These are all things that I had very little experience with before, and very little reason to dig into so deeply. Not represented here are the 40 or so academic papers that I identified as important, and seriously set out to read and take notes on -- again, probably learning more deeply these topics than I otherwise would have.

Which brings me to this theory, the idea of this post: That by even beginning to work on this problem, I'm seeing some gains, and that any tools I can build that give me further gains will only compound the impact and effectiveness. **Improving cognition and learning compounds to allow further gains in cognition and learning.**

There's some idea in the artificial intelligence community that we don't need the first general artificial intelligence to be built as a super-intelligence; we need only build an artificial intelligence that is capable of improving itself (or a new generation of artificial intelligence.) As each generation improves, such intelligences could become unfathomably intelligent. But all it takes is that first seed AI that can improve the next.

So for improving our own human intelligences, we may not need to build a single device up-front that makes us massively intelligent. We only need take measures to improve our current knowledge and cognition, to build tools that will help us improve further, and continue down this path. It will definitely not be the exponential gains predicted for AI, and may not be even linear -- that is, the gains in cognition from building further tools and learning more may plateau. But there will be improvements.

For that reason, I'm not setting out to build Manfred Macx's exocortex from the beginning. Instead, I have been building what I describe as a "Instapaper clone for doing research" -- a tool that, if it improves my existing ability to research and learn new topics, could pay off in helping me to build the next phase of my projects.

Of course, at the same time, I have an eye towards using the foundation of this tool as the datastore and relevance-finding tool for the overall project. Such a tool can automatically go and find related content -- either things I have read, or simply crawl related content on the web. Eventually, this tool will also ingest all of the information I interact with on a daily basis: every website I browse, every email I receive, every book that I read. A searchable, tagged, annotatable reference with full metadata for each document as an external long-term memory. But this is all a topic for another post.

This, in concert with what current research tells us is effective: [improved nutrition and supplementation, exercise, meditation, and N-back training](http://www.salon.com/2013/12/29/sciences_obsession_the_search_for_a_smart_pill/), may just be my ticket to higher levels of human intelligence. But for now, I just want the early-adopter edge. I want to see how far I can push myself on my own skills. Some large corporation may be able to field hundreds of developers to create a consumer product for the public that benefits everyone in similar ways -- but I might be able to do this for myself years ahead of that. And wouldn't that be cool?

And this is where I call it a theory: it could very well be that there's no such thing as compounding interest on intelligence. Only time and my own experiences with this project will tell me.

If you've made it this far and you're interested in this kind of stuff, that is: intelligence augmentation, wearable computing, autonomous proactive agents, etc., [get in touch](https://twitter.com/mathiasx). There doesn't seem to be much of an online community around these topics, and I'd like to start creating one for discussion and organizing open source projects around these topics.
