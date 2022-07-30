---
layout: post
title: "Atreus: My Custom Keyboard"
date: 2014-08-19 21:38
redirect_from:
  - /blog/2014/08/19/atreus-my-custom-keyboard/
---

Last year I wrote about about building [chording keyboards](/blog/2013/08/03/building-a-chording-keyboard-lessons-learned-and-progress-so-far/) and [USB foot pedals](/blog/2013/08/06/a-simple-text-editor-foot-pedal/). At the time, using the [Teensy micro controller](http://www.pjrc.com/teensy/) as a USB HID device was possible, but it still required a lot of research. There was no good central resource for knowledge about building keyboards. Since then, the [Ergo Dox](http://deskthority.net/wiki/ErgoDox) keyboard was released as open source and got quite popular. This seems to have opened the door for many to get into building keyboards.

My friend [Ian](http://coglib.com/~icordasc) ordered an Ergo Dox on the Massdrop crowdfunding campaign, after I suggested that I'd teach him to solder and we'd assemble it together. Finding time to get together and build it took almost a year, but we've started meeting up weekly to assemble the Ergo Dox. Building his keyboard has been a lot of fun, and inspired me to work on my own keyboard projects again.

Almost exactly a month ago, I started working on building my own keyboard. I wanted to build a keyboard from scratch that could replace my daily-driver keyboard, a PFU Happy Hacking Lite, so it had to be smaller than most [tenkeyless](http://deskthority.net/wiki/Tenkeyless) keyboards. The Ergo Dox's columnar layout was always intriguing, but I wasn't sure that I needed all those keys. (Normal keyboards stagger the keys of each row, which is a holdover from preventing mechanical typewriters from jamming. Columnar layouts assign a column of keys to each finger.)

Through [Geekhack](http://geekhack.org), I found the [Atreus](https://github.com/technomancy/atreus), a keyboard designed by [Phil Hagelberg](http://technomancy.us/) (better known as [technomancy](https://github.com/technomancy) online.) The Atreus is open source ([hardware](https://github.com/technomancy/atreus), [firmware](https://github.com/technomancy/atreus-firmware)), and has gone through several revisions at this point. My keyboard is done now, and I wanted to share it.


[![The completed Atreus keyboard](/images/2014-08-19-atreus/img_3220_14785511628_o-thumb.jpg){:class="center-thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3220_14785511628_o-resized.jpg)

[The original Atreus](http://technomancy.us/173) was constructed out of layers of laser-cut acrylic. Since then, some folks on the [Geekhack thread](http://geekhack.org/index.php?topic=54759.0) have redesigned the laser-cut design to be cut out of a sheet of birch plywood on [Ponoko](https://ponoko.com). Ponoko is a great: you upload a file and choose materials and size. The Ponoko website keeps you updated on your project's status as they check your design, pick materials, and so on. Later, your laser-cut project arrives in the mail. I highly recommend Ponoko's service if you need laser cutting and can't get it done at a local makerspace.

[![Sheet of plywood with the Atreus pieces laser cut into it](/images/2014-08-19-atreus/img_3156_14785346149_o-thumb.jpg){:class="center-thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3156_14785346149_o-resized.jpg)

I finished the birch ply with semi-gloss marine polyurethane. The polyurethane should give it a durable finish, and added a nice amber tint to the wood. The downside is that more than a week after the final coat went on, the poly is still out gassing some headache-inducing fumes.

After applying the finish, I hot-glued the switches in and soldered it together. There's no PCB with this design, just point-to-point with wires and components to a central Teensy. I used [Cherry MX Clear](http://deskthority.net/wiki/Cherry_MX_Clear) switches for the majority of the keys because they seem the closest to my Happy Hacking's Topre switches to me. The modifiers are [Cherry MX Blacks](http://deskthority.net/wiki/Cherry_MX_Black).

Assembling the Atreus with point-to-point soldering wasn't too bad, but I've had a lot of experience soldering. I've no doubt that the construction will be durable and reliable, but a PCB might make it easier to assemble for beginners. There's some talk on Geekhack about using the [One Hand PCB](http://deskthority.net/workshop-f7/onehand-20-keyboard-t6617.html) as a circuit board for a Atreus-like keyboard.

The rest of my images from the build appear below:

[![Assembling the case](/images/2014-08-19-atreus/img_3162_14769295254_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3162_14769295254_o-resized.jpg)
[![Fitting the key switches to the Atreus](/images/2014-08-19-atreus/img_3204_14785346299_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3204_14785346299_o-resized.jpg)
[![Fitting the key switches to the Atreus 2](/images/2014-08-19-atreus/img_3206_14785441468_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3206_14785441468_o-resized.jpg)
<div class="clearfix"></div>
[![Gluing the switches to the plate with hot glue](/images/2014-08-19-atreus/img_3207_14972030495_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3207_14972030495_o-resized.jpg)
[![Soldering the diodes to the switches](/images/2014-08-19-atreus/img_3208_14785358190_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3208_14785358190_o-resized.jpg)
[![Preparing the wires for columns by removing the insulation](/images/2014-08-19-atreus/img_3209_14949067746_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3209_14949067746_o-resized.jpg)
<div class="clearfix"></div>
[![Soldering the column wires to the keyboard](/images/2014-08-19-atreus/img_3210_14785358580_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3210_14785358580_o-resized.jpg)
[![Soldering the column wires to the keyboard 2](/images/2014-08-19-atreus/img_3211_14785510338_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3211_14785510338_o-resized.jpg)
[![Connecting two halves of the keyboard with wires](/images/2014-08-19-atreus/img_3213_14785564777_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3213_14785564777_o-resized.jpg)
<div class="clearfix"></div>
[![The Teensy wired into the keyboard with wires running to columns and rows](/images/2014-08-19-atreus/img_3218_14949137106_o-thumb.jpg){:class="thumb" loading="lazy"}](/images/2014-08-19-atreus/img_3218_14949137106_o-resized.jpg)
<div class="clearfix"></div>

After hours of soldering, the moment of truth came: I plugged in the Teensy, uploaded the firmware, and typed some keys. It worked! I felt relieved that the keyboard worked on the first try. Because I had checked for continuity and shorts throughout the soldering process, I can be confident that my Atreus won't have any issues with ghosting or glitches. The finished keyboard feels really solid; maybe more so than some plastic keyboards I've typed on before.

Because the Atreus uses a columnar layout, I'm not planning to use it with a QWERTY layout. So, I decided to learn Dvorak. I've been practicing on the home row on [dvorak.nl](http://dvorak.nl), which is a great website for learning Dvorak in your browser. The neat thing about that typing tutor is that you don't have to commit to changing any key layouts at the OS-level. I've got the default QWERTY layout on my Atreus now, but will be switching to a hardware-native Dvorak layout soon.

Since the Atreus uses a Teensy as its brain, it can be reconfigured easily by uploading a new firmware. Keyboard layouts for the Atreus start as a JSON file, and then an emacs function can be invoked to compile and upload the firmware to the board. The same JSON file can also be used to generate an HTML table of the layout with Org Mode in emacs. More information can be found on the [firmware project repo](https://github.com/technomancy/atreus-firmware).

## What next?

I haven't worked on my chording keyboard in a long time.  I'm happy to see that things like the [tmk firmware](https://github.com/tmk/tmk_keyboard) will now make that project much easier. With my new knowledge and the many open source projects now available, I'm going to restart work on [that project](/blog/2013/08/03/building-a-chording-keyboard-lessons-learned-and-progress-so-far/).

Further, I've been playing with Matt Adereth's [dactyl](https://github.com/adereth/dactyl) to design chording keyboard layouts. Dactyl allows me to write Clojure code and output it in a format that OpenSCAD can generate a 3D model with. OpenSCAD can export the files to the formats that 3D printers use. 3D printing has a lot of promise for iteratively prototyping unique ergonomic peripherals, and I intend to try out several ideas for one-hand / chording keyboards.

If you're interested in building your own keyboard, I would recommend the Ergo Dox. Especially if you can get the kit that Massdrop produced, because the circuit boards are well-made. Otherwise, spend some time on the Geekhack & Deskthority forums, read some wiki pages, and test some keyboards. And if you're interested in building the Atreus, join the [discussion](http://geekhack.org/index.php?topic=54759.0)! Everyone in that thread has been very helpful.  This project wouldn't have been possible without their answers and advice.

---

Interested in commenting or contacting me? Send an email to [contact@mattgauger.com](mailto:contact@mattgauger.com). Thanks!
