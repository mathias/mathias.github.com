---
layout: post
title: "Why build intelligence augmentation tools?"
date: 2017-04-10 10:48
redirect_from:
  - /blog/2017/04/10/why-build-intelligence-augmentation-tools/
---

In a [past blog post](http://blog.mattgauger.com/blog/2014/01/12/a-theory-of-compound-intelligence-gain/) I talked about the concept of *intelligence augmentation*. The idea of building software to augment intelligence has been around for some time. That post covers its history more than this one will.

I've noticed that software developers I know (myself included) will have a thought: Imagine a tool that would allow flexible note-taking, archive and index their documents and email, and enable hyperlinking to any content in that index. This tool would have some sort of AI agent architecture on top of it that would offer improved searching, find related content automatically, and otherwise assist you in thinking and researching. Variations on this tool might include improved filtering of incoming information, or improving their own ability to learn new things.

Such thoughts tend to lead people to start designing architectures and picking programming languages to implement it in. Or they might start designing a UI. Or they fall down the rabbit hole of knowledge systems, machine learning, and natural language processing.

Indeed, such a note-capturing system is the [source of inspiration for loper-os](http://www.loper-os.org/?p=8), a more-perfect Lisp machine project envisioned and taken up by Stanislav Datskovskiy. (Although he is still working on the hardware on which to write loper-os and thus run his thought-capturing system. Again, rabbit holes.)

I've had discussions with at least a dozen other people about how they would build such a virtual assistant. Clearly, there's some tooling lacking here that a lot of people have thought about and feel a need for.

Why is building a virtual assistant such a tempting thought for software developers? It's likely because they experience technology as constant change. Their work and communication revolves around technology.

The tools and services we use now (read: Twitter, Facebook, email, and so on) only compound the [information overload](https://en.wikipedia.org/wiki/Information_overload) that occurs when you try to stay up to date with your email and your calendar. Or when you try to stay up to date with everyone on social media. Suffice to say, the people who use technology the most may feel this pain the greatest.

Let's take a step back and think about why we would want to augment our own intelligence. And in particular, I'm going to focus on building software here. We could also have discussions around using smart drugs (nootropics), or of using genetics and medicine. Or we might discuss building hardware such as [brainports](https://en.wikipedia.org/wiki/Brainport) or [Elon Musk's neural lace](https://www.youtube.com/watch?v=ZrGPuUQsDjo), but those are out of scope for this article and for my expertise. Software I know.

In 1997, Garry Kasparov lost to Deep Blue at chess. This was the first case of a computer defeating a world champion. After this point, advances in computing power meant that off-the-shelf chess software running on a modern laptop can play as well as Deep Blue. Since the search space of chess is now in the CPU's reach, no human can hope to beat the best computer at chess again.

Yet, Kasparov noticed something. If you combine software with a human player, and let the human use the computer software to explore the results of a particular move before making it, that team plays better than man or computer alone. They call these man-machine hybrids "centaurs." Kasparov called this game [Advanced Chess](https://en.wikipedia.org/wiki/Advanced_Chess), and an offshoot called freestyle chess has emerged with teams of humans and computers on each side.

To bring it back to our terminology, a centaur composed of a human operating a computer is an *augmented human*. The chess software is an intelligence augmentation tool. Now, chess and its rules are not something as complex as writing a more compelling document or pulling together disparate academic papers and original research into one new thesis. We do not yet have the tools to enable a regular researcher to become a super-researcher simply by giving them software to consult.

The complexity of problems that we need to solve is ever-increasing. This was the main reason that [Engelbart cited](http://www.dougengelbart.org/pubs/augment-3906.html) in 1962 for exploring augmenting human intellect:

> Man's population and gross product are increasing at a considerable rate, but the complexity of his problems grows still faster, and the urgency with which solutions must be found becomes steadily greater in response to the increased rate of activity and the increasingly global nature of that activity. Augmenting man's intellect, in the sense defined above, would warrant full pursuit by an enlightened society if there could be shown a reasonable approach and some plausible benefits.

The benefits to be able to create a super-researcher or super-productive professional should be obvious. There are likely aspects of your job or your hobbies that you can imagine aided by better software.

In particular, when we augment the brain, we will look at it like another piece of technology:

* improving short and long term memory recall (storage)
* improving the number of different ideas we can hold in our heads at once (RAM)
* improving the speed, focus, and association-making aspects of our thinking (CPU)

What kinds of features might we want to see in these tools? A possible, but not exhaustive, list might include:

* filtering the noise of your email inbox, news sources (and fake news), social media, and more
* proactively providing related content and automatically categorizing content
* visualizing and summarizing information so that you can work with it more effectively
* helping us to remember everything we've ever seen, heard, or said in the real world
* helping us remember names and otherwise augment our social ability
* optimizing our time, schedule, and work load (as SRI's CALO focused on)
* optimizing our health (as an outgrowth of the [quantified self](http://quantifiedself.com/) movement)

So we, as software developers and [tool-makers](http://blog.mattgauger.com/blog/2017/03/12/mining-for-computation-on-the-beach/), see a need and want to build tools. We know what kinds of tools we might create. But why else might we, as humans, want to build these tools?

## Productivity

If we extrapolate from the Advanced Chess centaurs, then augmented humans will be better than unaugmented workers. In some cases, augmented humans will be able to get more work done than AI/ML tools. In a time when automation continues to threaten our jobs, we might yet find meaningful work for a longer period of time if we can join with machine learning technologies to become augmented humans. In the short term, being more productive is more likely to earn you raises and advancement. You may have better choices about what to work on, or how you work with it.

A worker becomes more valuable as their ability to solve more problems and get more done increases. A more productive work force can help us to have a healthier economy and to smooth the transition to a fully-automated world. Once we reach that level of automation, we can hope to find post-scarcity, an end of wage labor, and the ability to fill our time with leisure.

The downsides to augmenting for productivity are that if there are some barriers to entry here, such as cost, then only the rich can afford such tools. The average worker still won't benefit from expensive productivity improvements. Worse, we may not even see any benefit for those that weren't working in professional roles now. Those with jobs threatened by automation -- truck drivers, factory workers, and so on -- may be hardest hit by expensive or unavailable augmentation tools. We should focus on helping those workers train for their next career, and help those entering the workforce keep up.

## Education and better learning

The education system cannot move fast enough for the rapid pace of change. Those applying to college now should be looking at what jobs will be available in 5 years when they choose a major. Jobs that may become automated in that time makes those jobs a bad decision. But the existing college system does not tell students to avoid jobs that may soon be irrelevant.

If you are likely to change careers in your lifetime, does it make sense to pursue a particular degree? (At least, in cases where it is not required for certification/practice, such as law or medicine.) Or should you optimize for a lifetime of learning?

The cost of higher education is high, and most students take on loans to complete their degrees. Is this cost worth it? Do they learn enough in a degree to pay back the loans later? Do they retain enough information from that learning period to later use it in their job?

And if technology is moving so fast that colleges can't keep up, will workers be able to juggle learning new advances while working full time?

We need software that accelerates learning and increases retention. More learning in shorter periods of time can help students -- and workers in the workforce -- to keep up. Better retention means better job performance and success.

There's been a lot of research into learning on multiple fronts. I recommend the book [A Mind for Numbers](https://www.goodreads.com/book/show/18693655-a-mind-for-numbers) and its related MOOC [Learning How to Learn](https://www.coursera.org/learn/learning-how-to-learn) to find out more about this topic and how to put that research into practice.

There are a long list of startups now offering online courses, nano-degrees, and certificates of study. Khan Academy presents videos for elementary school studies through graduate admissions tests. But putting a class online as a screencast does not turn these courses into an intelligence augmentation tool.

There's the entire internet and all of Wikipedia available whenever we use a search engine. Ebooks give us access to a shelf of books without needing an expensive and wasteful physical copy. (Especially when it comes to textbooks.) There's note-taking applications and word processors with spell-checkers. There's flashcard apps, such as SuperMemo, that use a [spaced repetition](https://en.wikipedia.org/wiki/Spaced_repetition) to help with memorization and language learning. So why aren't these enough to enable people to learn better?

The difference between existing tools and what we need from educational augmentation tools is personalization to the learner and optimizing the learning. These existing tools are inert and require the learner to expend all of the energy and thinking to use the tool. Intelligence augmentation tools could be proactive learning tools that can do more than  provide the content to learn. They could actually bring the right content to the user at the right time (as in spaced repetition). They could structure the learning to the individual, rather than the current method of teaching to the widest range of students. They could let the learner explore at their own pace and go off on tangents of learning to related topics. Last, these tools would keep track of the current level of learning and track mastery of each topic.

All of these features are lacking in current tools. The area seems ripe for change and improvement.

## More free time

Increased productivity gives us more benefits than getting more done at work. We should have the ability to work less if we are more productive. This could free up more time for leisure, hobbies, entertainment, and further higher education goals.

Since there's an association (at least in the USA) between labor and success in life, it might be hard to convince ourselves that working less per week is a positive. Yet, I see the rise of full-time travelers, many of whom work as contractors for less than 40 hours per week, as an sign that this will become socially acceptable. These digital nomads might have the most success with intelligence augmentation tools and the work of the future (as [Charles Stross's Manfred Macx](http://www.antipope.org/charlie/blog-static/fiction/accelerando/accelerando.html) did.)

As we approach a post-scarce society (and hopefully we do), work for pay will have less importance. Being able to spend time with friends and family, be entertained, and pursue intellectual interests will all become more acceptable ways to spend our time.

## Solving complex problems

As noted by Engelbart, our world is increasingly complex. One way that academia has dealt with this is increasing specialization. A PhD may only have a deep expertise on a narrow subject. Outside of academia, we have the forces of globalization and technological progress to contend with. Narrow specialization may not always work. Our world changes rapidly and has difficult multi-disciplinary problems to solve. Global warming, food, clean water, and eradicating disease are all tough problems. How can we go about solving them?

In the space of all the possible intelligences, imagine intelligence drawn on a curve. On the top of that scale is the most intelligent human (Einstein, Newton, or any other that you wish.) The rest of us are somewhere in the middle of the scale, and on the lower end of the scale, animals. Of course, the graph goes much farther up and to the right than the smartest human so far. We just haven't seen those intelligences yet.

In that space of possible minds, there exists a new category. The augmented humans, or centaurs, have their own range of intelligences. Augmentation could allow regular humans reach a range that includes Einstein-level intelligence. For specific topics or skills, centaurs could rank much farther up the curve than the smartest humans. We've already seen this with Freestyle Chess: the best human chess players, unaugmented, are no match for a team of computers and humans working together. Augmented humans with good software will be able to surpass the smartest natural humans in multiple aspects, and we can give that augmentation software to far more people.

Intelligence augmentation tools won't just let us do more work faster, then, but unlock the ability to understand and solve problems that we previously could not. This will power new forms of technology and science well beyond what we've accomplished today.

## In conclusion

I'm excited to be thinking about and writing about these topics again. There's potential to start building some of these tools today. In particular, to build personalized tools as experiments. These early tools will be like the tracking done by the quantified self movement: separate data points from individuals with little overlap. But cross-pollination of ideas and techniques will be possible. Conversations around these experiments will be important to develop the technology further.

From these personal experiments, we can learn to build generic tools for everybody. Those generic solutions will allow the creation of freely-available software. Open source should help with concerns around access only being available to the wealthy and the privileged.

We'll still be on our own to deal with the ethics involved in augmentation, which I did not touch on in this article.

If you find these topics interesting and would like to discuss them, I invite you to join me over on the new [Intelligence Augmentation BBS](https://intaug.org).
