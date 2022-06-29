---
layout: post
title: "Minsky's Circle Algorithm in Shoes.rb / Hackety Hack"
date: 2013-07-27 11:32
redirect_from:
  - /blog/2013/07/27/minskys-circle-algorithm-in-shoes-dot-rb-slash-hackety-hack/
---

---

*(This post is part of my blog archiving project. This post appeared on [Coderwall](https://coderwall.com/p/fukypa) on July 27, 2013.)*

---

I wanted to try to implement Minsky's Circle Algorithm from the famous [HAKMEM](http://en.wikipedia.org/wiki/HAKMEM). As noted in lots of other places online ([1](http://brainwagon.org/2010/08/09/drawing-circles-ala-marvin-minsky/), [2](https://news.ycombinator.com/item?id=3111501), [3](http://cabezal.com/misc/minsky-circles.html)), the algorithm doesn't plot a true circle, but rather a very round ellipse. Here's the text from the HAKMEM entry:

> ITEM 149 (Minsky): CIRCLE ALGORITHM Here is an elegant way to draw almost circles on a point-plotting display:
{% highlight plaintext %}
NEW X = OLD X - epsilon * OLD Y
NEW Y = OLD Y + epsilon * NEW(!) X
{% endhighlight %}
> This makes a very round ellipse centered at the origin with its size determined by the initial point. epsilon determines the angular velocity of the circulating point, and slightly affects the eccentricity. If epsilon is a power of 2, then we don't even need multiplication, let alone square roots, sines, and cosines! The "circle" will be perfectly stable because the points soon become periodic.
>
> The circle algorithm was invented by mistake when I tried to save one register in a display hack! Ben Gurley had an amazing display hack using only about six or seven instructions, and it was a great wonder. But it was basically line-oriented. It occurred to me that it would be exciting to have curves, and I was trying to get a curve display hack with minimal instructions.

The benefit of using this algorithm, at the time, was that it doesn't use cosine/sine or any other complicated functions, and so could be implemented on the rather-limited computers of that time to draw circles fast. (I believe it was used to draw the orbits of ships on the early game [SpaceWar](http://en.wikipedia.org/wiki/Spacewar_(video_game), but I don't know that for sure.)

To implement it myself, I needed to be able to plot points on a display. So I turned to Hackety-Hack, which comes with Shoes for drawing graphics. The Shoes DSL for drawing shapes is rather simple, which means we can take the pseudocode above and turn it into a working demo rather easily:

```ruby
Shoes.app do
  epsilon = 1.0/16
  offset = 250
  x = 20
  y = 20

  fill red
  shape do
    move_to(x + offset,y + offset)

    100.times do
      x = x - epsilon * y
      y = y + epsilon * x
      line_to(x + offset,y + offset)
    end
  end

  fill blue
  oval({top: 250, left: 320, radius: 25, center: true})
end
```

Epsilon is 1/16, as indicated by some quick googling -- basically a small power of two. I have to use the offset to get the center of the circle closer to the center of the Shoes window -- without the offset, the circle will only be a quarter-circle in the upper left corner.

## How does this compare to plotting a real circle?

If we want to compare the roundness of our "circle" to a real circle drawn by Shoes, we can add this line in before the closing `end`:

```ruby
  fill blue
  oval({top: 250, left: 320, radius: 25, center: true})
```

Although their radiuses are going to be slightly different.

Here's what we end up with. Minsky's Circle Algorithm on the left in red, a real circle on the right in blue: *Note from June 2022: the image previously linked here has been lost to bit rot and time.*
