---
layout: post
title: "WARNING: Nokogiri was built against LibXML version x.x.x"
date: 2013-05-23 11:46
redirect_from:
  - /blog/2013/05/23/warning-nokogiri-was-built-against-libxml-version-x-dot-x-x/
---


(This post is part of my [blog archiving project](/about#old-posts). This post appeared on [Coderwall](https://coderwall.com/p/kia38w) on May 23, 2013.)


When you run tests or rake, if you see:

    WARNING: Nokogiri was built against LibXML version 2.9.0, but has dynamically loaded 2.7.8


Then do the following:


     gem uninstall nokogiri libxml-ruby

    brew update

    brew uninstall libxml2
    brew install libxml2 --with-xml2-config

    brew uninstall libxslt
    brew install libxslt
    brew unlink libxslt

    bundle config build.nokogiri -- --with-xml2-dir=/usr --with-xslt-dir=/usr --with-iconv-dir=/usr
    bundle


Nokogiri should now be compiled against the right version!
