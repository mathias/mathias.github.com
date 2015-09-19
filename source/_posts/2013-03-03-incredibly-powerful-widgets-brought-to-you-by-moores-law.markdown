---
layout: post
title: "Incredibly powerful widgets, brought to you by Moore's Law"
date: 2013-03-03 11:10
comments: true
categories: 
---

I've been teaching my downstairs neighbor basic electronics and how to solder. He's a musician and has been working his way through several kits from [Bleep Labs](http://bleeplabs.com/).

As I explained each component: the resistor, the capacitor, the diode, etc., I eventually got to the transistor. I told my neighbor how transistors are rarely used on their own now. The transistors in the kit were there mainly because they were easy to solder, but usually a circuit designer would opt not to use them.

On its own, a single transistor can't do much, and takes up some amount of space, which is actually quite large relative to the circuits we build now. I scored bags of hundreds of transistors that were about to be thrown out at the [Milwaukee Makerspace](http://milwaukeemakerspace.org/) when we were putting together the electronics lab &mdash; not because they didn't work but because that many transistors simply wouldn't get used. "Nowadays, you might as well throw an Arduino in a project," was one of the reasons. No one wants to work at the abstraction level of single transistors anymore.

It turned out that the [drum machine kit](http://bleeplabs.com/store/bleep-drum-midi/) that we were putting together contained an Atmel AVR microprocessor - the main chip of the Arduino. In an effort to save space and complexity, the designers had used a microprocessor instead of discrete transistors. The chip in the Arduino and the Bleep Drum is the ATmega328, which has something like 600,000 transistors inside it.
And I explained how the form factor of the components we were using was obsolete. Even the tight-packed pins of a typical integrated circuit (a computer chip, in common parlance), spaced at 0.1", just isn't dense enough for modern circuits. The parts we were using were all designed to be soldered to the circuit board by human hands. Slow, error-prone human hands. The vast majority of circuit boards produced today are [surface mount](http://en.m.wikipedia.org/wiki/Surface-mount_technology): parts placed by robots and soldered all in one go by another machine. 

"It's really neat that you know all this stuff," my neighbor remarked. But I shrugged it off. This knowledge, especially of how analog circuits work and how audio signals are modified by analog components, is mostly obsolete. Better to just use some analog-to-digital converters and put a microprocessor on it. Or better yet, something way more powerful than a simple microprocessor.

We keep putting more and more transistors on a single die, or chip, every day. This trend was first spotted by Intel co-founder Gordon E. Moore, and so we call it [Moore's law](http://en.wikipedia.org/wiki/Moore's_law). So far, Moore's prediction that the number of transistors on integrated circuits would double every 2 years has been quite accurate. It has led us from the simplest integrated circuit in 1958 to the Core i7 processor in my Macbook Air today.

The other day I tweeted about the crazy processing power that we get today under Moore's Law.

<blockquote class="twitter-tweet" align="center"><p>Crazy future; my MBA doesn't sweat when running Linux-in-VMware, Chrome, Emacs, LightTable, other apps, terminals &amp; 4 REPLs all at once.</p>&mdash; mathiasx (@mathiasx) <a href="https://twitter.com/mathiasx/status/307668858985140225">March 2, 2013</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

And in truth, I was running more software than I could fit into that tweet, because I was listening to music, had a few PDFs in the background, and was managing my ebook collection at the same time. But those notorious CPU hogs listed in the tweet should be enough to illustrate just how much is going on without really pushing the processing cores of the Macbook Air.

Remember, my 13" Macbook Air only weighs 2.96 pounds. In 2005, I had a 12" Powerbook G4 that weighed 4.6 pounds and had, by my back-of-the-envelope calculations on Geekbench scores <sup><a href="#geekbench-notes" name="geekbench-notes-return">1</a></sup>, my Macbook Air is almost 9 times as powerful as the Powerbook G4 was.

Where is this progress taking us? Well, my iPhone is already pretty powerful. It's hard to get a raw number of FLOPS (floating-point operations per second) for the processor in an iPhone 4S, but we can get a Geekbench score for it. It is weighed against the same scale as the Macbook Air is measured on. On that scale, my iPhone measures<sup><a href="#geekbench-iphone-notes" name="geekbench-iphone-notes-return">2</a></sup> very close to the Powerbook G4 I had 8 years ago, but the iPhone has the advantage of having two cores.

Some people incorrectly read Moore's Law as "processor *speed* doubling every 2 years," which it is not. We've found that there's more to processing power than just gigahertz, though. The number of cores in a processor, and therefore the number of simultaneous things that a computer can do, is increasing. While there's some issues as we grow into this new paradigm where everything has multiple cores and we have to ensure consistency between them, this is overall a net win for those of us seeking more powerful computers.

To be honest, I don't really even notice my computer as physical hardware anymore. It is just the stage for software to run on: quiet, fast, lightweight, and very infrequently does the hardware bog down to make me wait. Only a few short years ago, we would have to wait for the computer to do something -- usually shown as the hourglass on Windows and the spinning beachball on Macs. Even things like copying a file between two directories could stop a system in its tracks, and the computer would simply stop accepting any input from the user. Now, processors, RAM, and SSDs are so fast that I rarely have to wait for them. And if I do have to wait, say, for some piece of software to be installed, the fact that the computer is multicore means that I can go and browse the internet in another window without noticing.

It's likely that, just like the example of VMware running Linux running on my Macbook Air in the my tweet, eventually we will get to the point of having so much computing power embedded around us that we will virtualize everything. It's possible that we will take not just files or even processes between computing devices but the whole environment, a whole virtualized machine and operating system. As a thought experiment, imagine pausing a VMware virtual machine while it is performing some CPU-intensive task on your laptop. Now copy that paused VM over to another machine, and start it back up. The software will continue to chug along on the CPU-intensive task like nothing happened<sup><a href="#vm-notes" name="vm-notes-return">3</a></sup>. Advances in processing power, storage speed, and wireless networking speed will continue to progress until this process could be seamless to the user.

In some regards, sending the whole VM across the wire and starting it back up on another processor is simpler than trying to marshal a raw process between two machines, and ensure that the process can still run in the other machine's environment. It doesn't solve the problem of running one process on many machines at once, but it could be used in cases where we can spin up one copy of a process that we want to parallelize, and then copy that VM to many different machines with chunks of the dataset to process. In fact, that's basically how many large distributed processing projects like BOINC (the software that SETI@Home runs on) work.

And so it's likely that, for reasons of ease of use, sandboxing for security and safety, and simply because we have so much processing power, in the future our phones and our wearable computers will simply be running a virtual machine. Then we don't need to worry about what software is running on our desktop PCs when we get home and have access to a larger display; we just move our processing over to the desktop computer, which ever is more convenient. (Even more likely is that we just have a display that acts like an accessory that we can "throw" the video onto, rather than having a separate desktop computer.)

The things around us are getting progressively more powerful by way of cheap, small processors. Where before I was saying that electronics hobbyists would rather use an Arduino into a project than deal with many transistors, industry would rather throw a small ARM processor into everything around us and write software than design a custom piece of hardware.

Case in point, over on the Panic blog, the case of [The Lightning Digital AV Adapter Surprise](http://www.panic.com/blog/2013/03/the-lightning-digital-av-adapter-surprise/). After wondering why the new Lightning AV adapter for the iPad mini took a few moments to boot up, and seemed to display a scaled version of the video, they cracked open the Lightning AV cable to find: an ARM processor! As far as they can tell, the iPad mini sends a bit of software to the processor in the Lightning cable every time it is connected, essentially booting the cable up, and sets an Airplay stream down the cable to the other end, where the ARM processor decodes it, upscales it to HD, and sends it to the TV. This makes the Lightning AV cable, in essence, the world's smallest AppleTV. And we thought the new AppleTV was small when it was debuted.

When I go to a concert now, the room is full of smartphones being pointed at the stage taking video or pictures. And while most people might think, "That's a lot of pictures and video that will be uploaded to Facebook," I think about the fact that the people in the room with me are holding more processing power in their hands than we had in most of the computer labs in my schools and in college. Those phones will just keep getting more powerful, and soon they'll match the performance of the Macbook Air I've got in my backpack. Even the mundane things will have plenty of processing power because it will be cheap and simpler to put a cheap processor in it. But those cheap processors are getting more powerful every day, and that is exciting.

So while I may have learned digital logic in college and can help you build up a simple adder from NAND gates, and as a hobbyist I've learned to build [guitar fuzz pedals from a few transistors](http://www.geofex.com/article_folders/fuzzface/fffram.htm), that knowledge is increasingly obsolete in the face of rapid progress. We will soon be packing powerful processors into everything around us, sometimes in surprisingly ways, simply because it is easier and cheaper than designing a custom piece of hardware. But the future is exciting, and that knowledge isn't completely useless, as long as I can share it with a few more people to show us just how far we've come.

---

<a name="geekbench-notes"></a>

**1.** 

"Geekbench scores are calibrated against a baseline score of 1,000 (which is the score of a single-processor Power Mac G5 @ 1.6GHz). Higher scores are better, with double the score indicating double the performance."

Scores: 

* [MacBook Air (13-inch Mid 2012)](http://browser.primatelabs.com/geekbench2/1713385): 7675
* [PowerBook G4 (12-inch 1.5 GHz)](http://browser.primatelabs.com/geekbench2/1545796): 861

<a href="#geekbench-notes-return">&#8617;</a>

<a name="geekbench-iphone-notes"></a>
**2.** Geekbench score for [iPhone 4S](http://browser.primatelabs.com/ios-benchmarks): 651 <a href="#geekbench-iphone-notes-return">&#8617;</a>

<a name="vm-notes"></a>
**3.** Of course, there's some issues with this. Anything that was happening synchronously would probably failed, as well as anything that depends on a network connection in progress. But for the purposes of the thought experiment, let's ignore those problems. <a href="#vm-notes-return">&#8617;</a>
