---
layout: post
title: ! '/Library/Ruby/Gems/1.8/gems/eventmachine-0.12.10/lib/eventmachine.rb:572:in
  `start_tcp_server'': no acceptor (RuntimeError)'
published: true
redirect_from:
  - /blog/2010/10/13/-library-ruby-gems-1-8-gems-eventmachine-0-12-10-lib-eventmachine-rb-572-in-start-tcp-server-no-acceptor-runtimeerror-/
  - /blog/2010/10/13/-library-ruby-gems-1-8-gems-eventmachine-0-12-10-lib-eventmachine-rb-572-in-start-tcp-server-no-acceptor-runtimeerror/
  - /2010/10/13/-library-ruby-gems-1-8-gems-eventmachine-0-12-10-lib-eventmachine-rb-572-in-start-tcp-server-no-acceptor-runtimeerror-/
---

<p>Seeing this error when trying to run your Rack or Sinatra webapp?</p>
<p>It's probably because you're already running something on the port you're trying to use. This happens quite a bit if you're using daemonized Rack apps that go off on their own after you close the controlling shell.</p>
<p>Use this command to see what's happening on a port:</p>
<div class="CodeRay">
  <div class="code"><pre>$ lsof -i :4567
COMMAND   PID     USER   FD   TYPE     DEVICE SIZE/OFF NODE NAME
ruby    74716 mathiasx    5u  IPv4 0x073562a4      0t0  TCP *:tram (LISTEN)</pre></div>
</div>

<div>It'll help you see the PID of the process that's hogging that port. Just be careful not to kill anything that <strong>should</strong> be on that port!</div>
<p>&nbsp;</p>
