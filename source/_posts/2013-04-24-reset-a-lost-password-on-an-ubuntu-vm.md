---
layout: post
title: "Reset a lost password on an Ubuntu VM"
date: 2013-04-24 11:46
---

---

*(This post is part of my blog archiving project. This post appeared on [Coderwall](https://coderwall.com/p/vibura) on April 24, 2013.)*

---

You may be like me and keep a couple virtual machines around on your laptop for development, testing, and gaming. I had an Ubuntu VM in VMWare that I'd lost the password to, and I wanted to reset it so that I could get back to coding.

Typically, with a desktop computer or a server, you hold down some key while the computer is booting to get into the Grub boot manager and then boot into something called "single user mode", where you're able to change passwords, fix configs, repair disks, etc.

Unfortunately, the boot screen just flies right by in Ubuntu under VMWare. So the first thing you'll need to do is shut down the VM, and then get ready to start it up. **But before you start the VM**: get ready to hit `Shift` because that's what will get you into Grub. Ready? Ok. Boot it and hit `Shift`.

Now you should be in Grub. If you don't get it, don't worry, just shut down and try again.

Choose the 'Advanced Options' and then any of the "recovery" lines from the Grub menu for Ubuntu.

You'll get dropped into another menu system. Choose `root`: this is the single-user mode where you are root.

Your / filesystem may be mounted as read-only at this point. Type this to mount it as read-write:

```
mount -rw -o remount /
```

Now you can reset passwords, etc, like this:

```
passwd myuser
```

Good luck!
