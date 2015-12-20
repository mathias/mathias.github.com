---
layout: post
title: Shiny, Captain!
published: true
---
<p><span style="font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-size: 14px; line-height: 19px;">
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;"><span style="color: #424037; font-family: Arial, Helvetica, sans-serif; font-size: 12px; line-height: 21px;">(This post is part of my blog archiving project. This post appeared on <a href="http://blog.mattgauger.com/2009/12/26/shiny-captain/">blog.mattgauger.com</a>&nbsp;on December 29. 2009.)</span></p>
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">Today I decided I wanted to start blogging again. I thought about my options on my hosting, and didn&rsquo;t particularly feel like running a full-blown blog engine like Wordpress or Drupal. I knew I wanted a nice custom theme but I didn&rsquo;t want to waste time trying to wrap my head around another theming engine.</p>
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">In the very far past, I had a blog run on a friend&rsquo;s server that was generated as static html files (and an RSS feed) by a perl script. It&rsquo;s still available on&nbsp;<a href="http://web.archive.org/web/*/http://tranzor.net/~xiphias" style="font-size: 14px; vertical-align: baseline; background-color: transparent; color: #47353b; padding: 0px; margin: 0px;">archive.org</a>. There are several Ruby-based projects that do the same thing. I chose&nbsp;<a href="http://github.com/mojombo/jekyll/" style="font-size: 14px; vertical-align: baseline; background-color: transparent; color: #47353b; padding: 0px; margin: 0px;">Jekyll</a>, which is what&nbsp;<a href="http://pages.github.com/" style="font-size: 14px; vertical-align: baseline; background-color: transparent; color: #47353b; padding: 0px; margin: 0px;">Github Pages</a>&nbsp;runs on. I grabbed the gem off the Github gem server and set up the basic directory structure. The whole setup is extremely simple:</p>
<div class="CodeRay">
  <div class="code"><pre>.
        |-- _config.yml
        |-- _layouts
        |   |-- default.html
        |   `-- post.html
        |-- _posts
        |   `-- 2009-12-26-shiny-captain.md
        |-- _site
        `-- index.html</pre></div>
</div>

<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">After creating those files, I was off and running with creating a theme from scratch. I&rsquo;ve had my eye on HTML5 for awhile, and recently read an&nbsp;<a href="http://www.smashingmagazine.com/2009/08/04/designing-a-html-5-layout-from-scratch/" style="font-size: 14px; vertical-align: baseline; background-color: transparent; color: #47353b; padding: 0px; margin: 0px;">article on Smashing Mag</a>&nbsp;that inspired me. I used their method of defining the HTML5 tags as blocks in CSS to allow me to write HTML5 now and render it in today&rsquo;s browsers.</p>
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">After a few hours, while my girlfriend watched Law &amp; Order SVU on Netflix next to me, I coded up the theme for this blog. I stole the template for the&nbsp;<a href="http://blog.mattgauger.com/atom.xml" style="font-size: 14px; vertical-align: baseline; background-color: transparent; color: #47353b; padding: 0px; margin: 0px;">Atom feed</a>&nbsp;from&nbsp;<a href="http://github.com/mbleigh/mbleigh.github.com/blob/master/atom.xml" style="font-size: 14px; vertical-align: baseline; background-color: transparent; color: #47353b; padding: 0px; margin: 0px;">mbleigh</a>. There&rsquo;s still plenty of room for tweaks and improvements I want to make. But I&rsquo;m trying not to be a perfectionist, and instead follow the maxim of&nbsp;<em style="font-size: 14px; vertical-align: baseline; background-color: transparent; padding: 0px; margin: 0px;">release early, release often</em>.</p>
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">Below is the &ldquo;Hello World&rdquo; post I whipped up initially to help with theming:</p>
<hr />
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">This is the first post!</p>
<blockquote style="margin-top: 1em; margin-right: 3em; margin-bottom: 1em; margin-left: 3em; padding-top: 0px; padding-right: 0px; padding-bottom: 0px; padding-left: 1em; border-top-width: 0px; border-right-width: 0px; border-bottom-width: 0px; border-left-width: 2px; border-color: initial; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #999999; border-left-style: solid; border-left-color: #999999;">
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">this is a block quote!</p>
</blockquote>
<p style="margin-top: 0px; margin-right: 0px; margin-bottom: 1em; margin-left: 0px; font-size: 14px; vertical-align: baseline; background-color: transparent; color: #000000; font-family: DroidSansRegular, Bitstream Vera Sans, Verdana, sans-serif; font-weight: 400; line-height: 1.4em; letter-spacing: 0px; text-align: left; padding: 0px;">This isn&rsquo;t a block quote!</p>
<div class="CodeRay">
  <div class="code"><pre>(Hpricot(open url)/:enclosure).map {|x| x.attributes[&quot;url&quot;]}.uniq.each do |vid|
        # File.exist?(vid.split(&quot;/&quot;).last) ? next : `curl #{vid}`
        filename = vid.gsub(/http:.+\//, '')
        filename.gsub!(/-/, &quot;_&quot;)
        next if File.exist?(filename)

        puts &quot;Downloading #{vid}&quot;
        puts filename
        `curl -L #{vid} &gt; #{filename}`</pre></div>
</div>

</span></p>
