---
layout: post
title: "A simple text editor foot pedal"
date: 2013-08-06 15:06
---

When I first starting talking about [building a chording keyboard](/blog/2013/08/03/building-a-chording-keyboard-lessons-learned-and-progress-so-far/), both in person and online, people began to ask me about the possibility of building a computer foot pedal. With the Teensy microcontroller, a foot pedal would only need to watch a single digital input and output a few characters to the OS; much simpler than my chording keyboard project.

## Commercial products

There are quite a few commercial products you can buy. They come with their own caveats:

* [Kinesis](https://www.kinesis-ergo.com/products/#foot-section) makes several, but they can only be programmed on Windows. They are also very expensive.
* The [Xkeys Foot Pedals](http://www.xkeys.com/xkeys/xkfoot.php) look good, but they are also expensive.
* The DealExtreme [Triple Action Foot Pedal](http://dx.com/p/usb-triple-action-foot-switch-keyboard-control-foot-pedal-56508) provides three buttons and is relatively cheap; however, the reviews I've read say the reliably is poor. This product can only be programmed on Windows.

## Building the foot pedal

My first idea for a foot pedal was to use DIY guitar pedal hardware. Such guitar pedals have nice, sturdy aluminum project boxes, robust foot switches, and look pretty good. But the ergonomics of such a pedal worried me: while a guitarist momentarily stomps on guitar pedals to turn them on or off while standing, a programmer would likely be tapping and/or holding a foot pedal for long periods of time, most likely from a seated position.

<img src="/images/guitar_pedal_true_bypass_looper.JPG" alt="true bypass looper" style="display: block; margin: 0 auto;" />

Such a pedal would look something like the above, but with a USB cable coming out of it.  If you wish to use guitar pedal hardware, I suggest checking out [Mammoth Electronics](http://www.mammothelectronics.com/). (I receive no compensation for mentioning them; I have been a happy customer for several years.) For a two-to-three switch foot pedal, I suggest the 1590BB enclosures, and Mammoth can drill them in several ways for you.

My coworker [Chris Wilson](http://sencjw.com/) suggested that I try a digital piano foot switch. These are relatively cheap and extremely sturdy. I picked up an [M-Audio Sustain Pedal](http://www.amazon.com/M-Audio-Sustain-Pedal-Action-Keyboards/dp/B00063678K/) from Amazon for about $17.

The sustain pedal is designed to plug into a digital piano, so it has a 1/4" audio plug on its cable. In the past, I've built a lot of guitar effects pedals and some amps, and so I have a lot of 1/4" jacks around.

The wiring is simple: The Teensy (and most Arduinos) can do input pullup resistors for us. I mocked up the circuit with a little breadboard (ignore the weird angle of the Teensy here; it was required to get the pins into this small breadboard.) I downloaded some example button code to the Teensy and verified that it was working.

<a href="http://www.flickr.com/photos/mattgauger/9454682228/" title="IMG_1897 by Matt Gauger, on Flickr"><img src="http://farm4.staticflickr.com/3725/9454682228_4bb073ea47_z.jpg" width="480" height="640" alt="IMG_1897" style="display: block; margin: 0 auto;" /></a>

To assemble, we simply solder a digital IO pin to one side of the 1/4" jack, and the other wire gets soldered to ground pin. My button is going to be connected on pin 9.

I had a small project box, much bigger than the Teensy really needed, but suitable for the job. I used my Dremel to cut a round hole for the 1/4" jack, and a rectangular slightly bigger than the mini-USB cable plug for our USB cable.

<a href="http://www.flickr.com/photos/mattgauger/9451903305/" title="IMG_1898 by Matt Gauger, on Flickr"><img src="http://farm4.staticflickr.com/3789/9451903305_4c6a3e0c35_z.jpg" width="480" height="640" alt="IMG_1898" style="display: block; margin: 0 auto;" /></a>

Test fitting the Teensy in the project box:

<a href="http://www.flickr.com/photos/mattgauger/9451906889/" title="IMG_1900 by Matt Gauger, on Flickr"><img src="http://farm4.staticflickr.com/3718/9451906889_8e5624fa7d_z.jpg" width="640" height="480" alt="IMG_1900" style="display: block; margin: 0 auto;" /></a>

Lastly, I used some velcro inside to attach the Teensy to the project box. All done with assembly!

<a href="http://www.flickr.com/photos/mattgauger/9451907469/" title="IMG_1902 by Matt Gauger, on Flickr"><img src="http://farm8.staticflickr.com/7451/9451907469_e6e6fc661f_z.jpg" width="480" height="640" alt="IMG_1902" style="display: block; margin: 0 auto;" /></a>

The next step is to program the Teensy to send the key events we want. In this case, my coworker [Josh](https://twitter.com/losingkeys) suggested a vim clutch that enters insert mode when you press down on the pedal, and leaves insert mode when you release it. Since the Teensy's Button class detects both button press and button release events, we can write code to do that.

Here's what the code looks like:

<script src="https://gist.github.com/mathias/6168386.js"></script>

(You can find the code in my chording keyboard repo on Github [here](https://github.com/mathias/chording/blob/master/teensy/foot_pedal/foot_pedal.ino).)

There are, of course, a few gotchas that I ran into:

The `KEY_ESC` constant that is referenced by the [Arduino documentation](http://arduino.cc/en/Reference/KeyboardModifiers) didn't work. Similarly, sending the hex value and character code didn't work. I couldn't find anything online that suggested that the Mac has some different ASCII character for the Escape key, so I had to find another way to leave insert mode.

With the Arduino's Keyboard class, we can build up a key combo by calling `Keyboard.press` for each character in the combo, and then finally calling `Keyboard.releaseAll` when we're ready to send the key combo to the computer. Since vim also has `Ctrl-[` as a way of leaving insert mode, I created that key combo on lines 34-36.

Of course, this code could be made to be even more robust by guarding against, say, inserting an `i` character when you are already in insert mode. Most likely, you'd send Ctrl-\[ (and move building the key combo to a function we can reuse) and then send vim the command `:startinsert`.  I'll leave implementing the more robust solution as an exercise for the reader.

## Final thoughts

Does it work? I used it while writing this blog post, but I must admit, I have a strong natural reflex to hit ESC to leave insert as soon as I finish typing a word or sentence. However, when consciously trying, it is quite natural to use the foot pedal to enter/leave insert mode. One downside I found was that the Ctrl-\[ combo seems to back up the cursor one character, which can be annoying.

For my personal use, I am thinking about mapping the key it sends to `Left-Alt` so that I can use the footpedal while in emacs' Org Mode and not have to move my left hand down to hit Alt with my ring finger every time I want to adjust a heading or start a new heading.

Overall, this pedal is much cheaper than the high-end pedals mentioned above. The total cost came to around $37, because I had some of the parts on hand. Further, you can upload new code to the Teensy on all operating systems, a big win over the Windows-only pedals above.

However, this pedal only has one foot switch. You could easily add more M-Audio sustain pedals to the design, and keep adding 1/4" jacks to a project box. The Teensy has plenty more IO lines to use! Or you could go for it all in one enclosure with the guitar pedal hardware.

<a href="http://www.flickr.com/photos/mattgauger/9451908041/" title="IMG_1903 by Matt Gauger, on Flickr"><img src="http://farm4.staticflickr.com/3780/9451908041_c8446aa3e7_z.jpg" width="480" height="640" alt="IMG_1903" style="display: block; margin: 0 auto;" /></a>

---

If you have any questions or comments, I'd love to hear about it [in an email](mailto:contact@mattgauger.com).


### Research:

* [Hackaday: Building a clutch for vim](http://hackaday.com/2012/06/21/building-a-clutch-for-vim/)
* [Arduino Keyboard modifiers](http://arduino.cc/en/Reference/KeyboardModifiers)
* [Emacs Wiki: Foot Swtiches](http://www.emacswiki.org/emacs/FootSwitches)
