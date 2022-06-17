---
layout: post
title: Another year, another keyboard built
date: 2022-06-17 07:54 -0500
---

In 2021, I decided it was time to build another keyboard. While I am happy with my daily driver keyboard, I'm always interested in trying out new options. Occasionally, I will find myself interested in learning and practicing a new keyboard layout and spend some hours towards getting to a low WPM speed.

I've been a happy user of the Atreus keyboard for years. The [original keyboard that I built in 2014](/2014/08/19/atreus-my-custom-keyboard/) came from a time period where the Atreus didn't have a PCB yet, so it was hand wired, and I ordered the case from a company that could laser cut it from wood. The heart of that keyboard is a Teensy microcontroller, which was a good option at that time. The firmware is a custom one that [technomancy](https://technomancy.us/) wrote. (@technomancy also designed the original Atreus and all credit for it goes to him, I merely built it.)

Between 2014 and last year, I'd also acquired the [Keyboardio version of the Atreus](https://shop.keyboard.io/products/keyboardio-atreus), and it is a great keyboard! It became a sturdy, unique little keyboard with Keyboardio's design tweaks, and the Keyboardio configuration tool made remapping much easier.

Since then, the DIY keyboard community has made a lot of progress. One can design a keyboard entirely with software and have the circuit boards printed by online companies. For open source boards, you can often print your own circuit boards for a reasonable price. The microcontrollers are much better than what we had in the Arduino and Teensy days, although most modern MCUs used are similar. Most importantly, I think, the [qmk firmware](https://qmk.fm/) has made programming and remapping keyboards from source code much easier and faster.

I'd always had an interest in the ergonomic benefits of a split keyboard, and the Atreus had convinced me that I was more interested in columnar layouts (where each column of keys is staggered to fit finger length, instead of staggered left-to-right in neat rows) than ortholinear keyboards (where the keys are in a strict grid, such as on the [Planck keyboard](https://olkb.com/collections/planck) that I own.)

After doing some research, particularly on the [SplitKB comparison tool](https://compare.splitkb.com/), I decided to build a SplitKB Kyria. The Kyria can be built with 34 to 50 keys, depending on whether you want two columns for the pinky finger, whether you want rotary encoders, and whether you want 2U thumb keys or 2 individual keys for the innermost thumb keys.

I ordered a kit from SplitKB and despite shipping from Europe during the pandemic, it arrived quickly. If you're reading this after around June 2022, then you may not have been aware, but global shortages of chips made for low stock of products like keyboard kits, and depending on country, imported packages sometimes sat in customs quarantine for a month or more.

The kit was easy to assemble, and I'd recommend it if you have some soldering skills. The surface mount LEDs are perhaps the hardest part to solder, but you could build it without. In retrospect, I could do without the RGB under-lighting, but that's just me.

At this point, I'll turn it over to showing the few photos I have from building the keyboard.

[![The Kyria kit in a cardboard box](/images/2022-06-17-kyria/thumbs/02-construction.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/02-construction-resized.jpg)

[![A close up of assembling the Kyria circuit board](/images/2022-06-17-kyria/thumbs/03-construction.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/03-construction-resized.jpg)
[![A close up of assembling the Kyria circuit board](/images/2022-06-17-kyria/thumbs/04-construction.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/04-construction-resized.jpg)
[![Flashing the Elite C microcontroller](/images/2022-06-17-kyria/thumbs/05-elitec-micro.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/05-elitec-micro-resized.jpg)

[![Microcontrollers soldered to Kyria circuit board halves](/images/2022-06-17-kyria/thumbs/06-mcus-soldered.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/06-mcus-soldered-resized.jpg)
[![Microcontrollers soldered to Kyria circuit board halves](/images/2022-06-17-kyria/thumbs/07-mcus-soldered.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/07-mcus-soldered-resized.jpg)

[![Assembling Kyria case and circuit board half](/images/2022-06-17-kyria/thumbs/08-assembly.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/08-assembly-resized.jpg)
[![Key switches being fitted to the Kyria keyboard with a screw driver behind it](/images/2022-06-17-kyria/thumbs/09-assembly.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/09-assembly-resized.jpg)

<div class="clearfix"></div>

I chose the [Colemak-DH key layout](https://colemakmods.github.io/mod-dh/) over my previous ["Capewell modified" layout](https://github.com/mathias/atreus-firmware/blob/capewell-modified/capewell-modified.json) that I use on the Atreus, because Colemak-DH is far more common on other ergonomic layouts I could find, and there's some small edge in statistical optimization to it. You can find my [whole keymap with some ASCII art](https://github.com/mathias/kyria-layout/blob/main/mathias/keymap.c) on my GitHub repo for my Kyria layout.

I have two rotary encoders on my build, with one side functioning as a volume knob and the other side functioning as a scroll wheel. Pressing down (clicking) the left rotary knobs activates the mode that allows me to change between QWERTY and Colemak-DH, and to adjust the RGB under-lighting. All these features are well-supported by qmk and work great.

I'm using a few qmk features like [mod tap](https://github.com/qmk/qmk_firmware/blob/master/docs/mod_tap.md) on the modifier keys so that `Ctrl` can function as `Esc` and `Alt` can function as `Enter`. Due to this, I think I could be productive with even fewer keys, likely by removing the outer column and saving my pinky fingers the stretch. Those columns are only `Tab`, `Left Shift`, and another `Ctrl/Esc` key on the left hand side, while the right does have a useful `'"` quote key that would need to move elsewhere. (The other two keys on the right, `Backspace` and `Alt/Enter`, are better handled by my thumb keys that do the same thing.) Additionally, I would remove the upper 1U thumb keys that expose `[`, `]`, and the `Nav` and `Fkeys` layers. I don't use those keys, so I could have built the thumb keys as 2U keys.

My Kyria has gone through many different sets of key caps, and I find I still prefer the DSA profile over any others. (I do have a set of KAT Space Cadet key caps that I'll have to build into something, eventually, because I think owning a Space Cadet style keyboard would be really fun and a nice nod towards my Lisp interests.)

[![The original keycaps: a set of DSA Granite keys in grey colors](/images/2022-06-17-kyria/thumbs/12-keycaps-1.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/12-keycaps-resized.jpg)
[![Kyria on a table while fitting the "Buzz Lightyear" themed key cap set](/images/2022-06-17-kyria/thumbs/11-keycaps-2.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/11-keycaps-resized.jpg)
[![A set of dished key caps from Massdrop that I tried and removed](/images/2022-06-17-kyria/thumbs/14-keycaps.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/14-keycaps-resized.jpg)
[![The "Space Cadet" key caps on the Kyria in grey and blue. Some of the key caps have the Greek/math and logic symbols like the original Lisp Machine keyboards.](/images/2022-06-17-kyria/thumbs/15-keycaps.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/15-keycaps-resized.jpg)

<div class="clearfix"></div>

While I'm not using the Kyria as a daily driver for work, it feels great to type on and I have been enjoying working through [keybr.com](https://www.keybr.com) exercises to learn Colemak-DH. If I were to make any changes, I think I could get away without the extra pinky row. And occasionally I will curse the wires connected everything when they get in the way. This makes me look towards something like a wireless Corne or Ferris/Sweep keyboard, but that will have to be a project for another blog post.

[![Half of my split keyboard, today, with the white, green, purple, and red key cap set](/images/2022-06-17-kyria/thumbs/16-keycaps.jpg){:class="thumb" loading="lazy"}](/images/2022-06-17-kyria/16-keycaps-resized.jpg)
<div class="clearfix"></div>
