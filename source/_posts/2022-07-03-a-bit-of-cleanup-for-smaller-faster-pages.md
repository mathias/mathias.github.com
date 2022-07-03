---
layout: post
title: A bit of cleanup for smaller, faster pages
date: 2022-07-03 16:41 -0500
---

I've now completed a pass at removing the Flickr images from this blog (many of which no longer rendered) and made a few other changes. There were several posts that used embedded Gists as a way to get syntax highlighting and a download link for each file. In the spirit of using less bandwidth, consuming less energy, and working better on mobile devices and everywhere else, I removed the inline script tags in favor of preprocessing syntax highlighting with [Rouge](https://github.com/rouge-ruby/rouge). It turns out that the syntax hightlighting was already built into the version of Jekyll that I was using for this blog, I just hadn't used it everywhere.

In addition to moving the images off Flickr, I pre-processed them with a small script and imagemagick so that the blog posts display smaller thumbnails, intended to be faster to load on mobile. The images lazy load, if the browser supports it, without any external JS, by using the `loading="lazy"` attr in the `img` tag. Each image links to a larger version, but the larger images have also been resized to a vertical height of 1080 pixels and compressed slightly to make them faster to load. Each replaced Flickr image also does not have to load a JS script tag from Flickr to render, which adds to the page size savings.

The images were preprocessed with [this script](https://github.com/mathias/mathias.github.com/blob/b6320db86eabb5dc0ac1a0dad220a065616eecc9/bin/prepare-image-directory.sh). Note: it is destructive to the originals in the directory where it is run.

In the case of the removed Gists, that added up to over 100 script tags removed from at least 7 blog posts. Since each script tag must be separately requested and run by the browser on every page load of one of those pages, this realizes a savings in bandwidth and clientside processing time.

I didn't measure the page sizes or load times before making these changes, but afterwards, I am measuring these sizes locally in Firefox with all assets (including scrolling to load all lazy-loaded images):

```
| Page                                                         | Size   | Requests    | Notes                       |
|--------------------------------------------------------------+--------+-------------+-----------------------------|
| / (homepage)                                                 | 21 KB  | 4 requests  |                             |
| /2022/07/03/a-bit-of-cleanup-for-smaller-faster-pages/       | 16 KB  | 4 requests  |                             |
| /2022/06/17/another-year-another-keyboard-built/             | 258 KB | 17 requests | has many images             |
| /2014/10/23/clojure-data-science-sent-counts-and-aggregates/ | 65 KB  | 4 requests  | had many gists              |
| /2014/03/30/clojure-data-science-ingesting-your-gmail-inbox/  | 108 KB | 4 requests  | largest page of text/markup |
```
