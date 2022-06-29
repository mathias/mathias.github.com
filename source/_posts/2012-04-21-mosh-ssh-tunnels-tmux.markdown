---
layout: post
title: "Mosh, SSH Tunnels, and Tmux"
date: 2012-04-21 21:14
redirect_from:
  - /blog/2012/04/21/mosh-ssh-tunnels-tmux/
---

---
*Update from June 2022: This post continues to be a popular post on search results, but it is quite old (10 years at this point! Longer if you're seeing this in the future.) So I recommend you consult the [mosh.org](https://mosh.org/) site for documentation and usage.*

---


I'm currently preparing for RailsConf. One of the things I wanted to do before I left was figure out a way to monitor a process on a Linux server running on my LAN. The process frequently crashes and needs some prodding to restart.

One solution might be to set up DynDNS and configure the router to point from some random port to the SSH port on the Linux machine running on the LAN. That idea didn't strike my fancy, as it just isn't terribly secure to open up a port to the entire world, and it seems that DynDNS costs money to use since 2008. I'm sure there are free alternatives, but I couldn't be bothered to find them, much less configure them.

A much better solution would be an SSH tunnel up to my Linode, and a reverse tunnel back down to the Linux server on my LAN. If you haven't used reverse SSH tunneling before, it is really neat. Here's an example:

From the local server:

    ssh -R 2048:localhost:22 username@example.com


From the server out in the Internet (aka example.com in this example)

    ssh -p 2048 other_username@localhost

Note that the 'localhost' in the second example refers to your local server, not the one out in the internet. So `other_username` should be the username on your local server (not the remote server.) Confused yet? Good.

Now, this setup will get you pretty far: You're now able to run commands on the local server from the Linode out in the cloud. But you may notice a problem fairly quickly: if you kill that SSH shell on the local server, the connection up to the server on the internet dies, and so does the reverse tunnel that was inside that.

Fix that by starting up a tmux session on the local server first, then detaching it.

    tmux new -s ssh-tunnel
    ssh -R 2048:localhost:22 username@example.com
    <leader-d>

Now the tmux session will happily keep that SSH shell open on the local server and you can reverse tunnel back over it.

My solution involves [Mosh](http://mosh.mit.edu), which I've been using quite a bit since it exploded on Hacker News and other news sites. Simply put, Mosh is like SSH, but it uses UDP packets to make itself more reliable. "More reliable without TCP?" you say? Well, Mosh is doing a little more work to buffer the connection to the other machine (including instant response to typing when there'd otherwise be lag) and maintains that connection: even if you change IPs, hop on a train, etc. It's pretty amazing, and so far I've been loving it. Click through to the Mosh site to read up more on it. It really is awesome.

With Mosh, we add another layer to the puzzle, so that my final setup looked like this:

    matts_laptop$ mosh matt@someserver.local
    matt@someserver.local$ tmux new -s ssh-tunnel
    <tmux session starts>
    matt@someserver.local$ ssh -R 2048:localhost:22 username@example.com
    <leader-d>

Pop open another window in my local tmux session (are you beginning to see a pattern?) and then connect with mosh up to my Linode:

    matts_laptop$ mosh me@mattgauger.com
    me@mattgauger.com$ tmux new -s server-monitor
    <tmux session starts>
    me@mattgauger.com$ ssh -p 2048 matt@localhost # Note: this is the matt@someserver.local account!
    matt@someserver.local$ <monitor the process I'm concerned with>

Now I've got this mostly-persistent (thanks to mosh and tmux) session that I can detach from if I really need to, but I'll still be able to connect back up to my Linode and check on the server on my LAN from RailsConf.

Pretty cool, huh?
