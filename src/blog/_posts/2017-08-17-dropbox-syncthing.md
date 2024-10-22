---
ogimage: /img/home-server.jpg
tags: howto
title: How to Replace Dropbox with Syncthing
---

Dropbox is convenient, but there are several reasons why you might want to drop it:

- You feel [uneasy](https://www.troyhunt.com/the-dropbox-hack-is-real/) about handing sensitive personal info to strangers
- You find the Dropbox client too resource hungry or [invasive](http://applehelpwriter.com/2016/08/29/discovering-how-dropbox-hacks-your-mac/)
- You don't want to pay for storage beyond the free 2 GB

The most popular open source, self-hosted alternatives to Dropbox are [ownCloud](https://owncloud.org/), [Seafile](https://www.seafile.com/en/home/), and [Syncthing](https://syncthing.net/). I went with Syncthing mainly because it's the smallest and simplest, following the Unix philosophy of doing one thing well. Much of its simplicity stems from the fact that Syncthing uses a peer-to-peer protocol as opposed to the other options' client-server models.

<p class="text-centered">
  <img alt="Dropbox logo" src="/img/dropbox.png" style="margin:10px 25px">
  <img alt="Syncthing logo" src="/img/syncthing.png" style="margin:10px 25px">
</p>

Here's how I made the switch:

1. **Set up a home server**

   In other words, obtain a computer that you can keep running 24/7. It doesn't need to be especially powerful: I use a Raspberry Pi attached to a portable 2 TB HDD. Plugging your server into a [UPS](https://en.wikipedia.org/wiki/Uninterruptible_power_supply) is a nice touch.

   It's important to have at least one peer always online so that _someone_ can provide a complete copy of your files at any given time. No syncing can ever actually take place if your devices never have the opportunity to sync with each other!

   But wait, doesn't this scheme sound more like client-server than peer-to-peer? The P2P aspect becomes more important in the event that your home server goes offline for whatever reason, e.g. your house burning down. That would be a single point of failure if not for the fact that your
   remaining devices can continue syncing among themselves as peers. (The [ideal](https://www.hanselman.com/blog/TheComputerBackupRuleOfThree.aspx) setup is to have two "server" peers located in different cities in order to protect your data from catastrophes that could otherwise wipe out your entire network of synced devices.)

1. **[Install](https://syncthing.net/#get-started) Syncthing on your devices**

   On Linux, I additionally use [Syncthing-GTK](https://github.com/syncthing/syncthing-gtk) for laptops and [Syncthing-inotify](https://github.com/syncthing/syncthing-inotify) for my headless home server.

   On Android, I use the unofficial [Anyplace Sync Browser](https://play.google.com/store/apps/details?id=it.anyplace.syncbrowser) app. It's bare-bones but much more practical than the [official app](https://play.google.com/store/apps/details?id=com.nutomic.syncthingandroid&hl=en) because it downloads files on demand instead of copying all of the files in your sync folder onto your phone. (Yes, you can have multiple top-level sync folders, but that's more complexity than I care for right now.)

   > Update on 2017-11-30: To use Anyplace Sync Browser on Nougat or above, you'll need to go into the system settings and manually grant it the "Storage" permission. Now I just use the official Syncthing app, though, since my current phone has enough space to fit my entire sync folder.

1. **Make your Dropbox folder your Syncthing folder**

   Before firing up Syncthing for the first time, stop Dropbox on all of your devices to prevent conflicts. Then start Syncthing on your home server. After it creates the [default files](https://docs.syncthing.net/intro/getting-started.html#syncthing), stop Syncthing. Locate the newly created sync folder, e.g. `~/Sync/default`.

   Now that both Dropbox and Syncthing are off, it's safe to symlink `~/Sync/default` to `~/Dropbox` or wherever your existing Dropbox folder is located. Alternatively, you can simply move/copy everything from your Dropbox folder into the new Syncthing folder.

   Start Syncthing again on your home server. On each of your other devices, you can now start Syncthing, add your home server as a remote device, and share the default sync folder. Adding the home server as an "introducer" has the benefit of automatically creating share connections among your non-home-server devices.

1. **Enable file versioning**

   One creepy but lifesaving feature of Dropbox is that it stores every version of every synced file ever. In contrast, a real danger with Syncthing is that file deletion propagates to all devices and is irreversible by default (unless, of course, the deleting device moved the file into a trash can folder somewhere).

   Fortunately, you can tell Syncthing to use either its own [trash can](https://docs.syncthing.net/users/versioning.html#trash-can-file-versioning) or Dropbox-style [file versioning](https://docs.syncthing.net/users/versioning.html#staggered-file-versioning). Whenever you delete or modify a file in a versioned sync folder, Syncthing places a timestamped copy of the original file into a special `.stversions` subdirectory of the sync folder. I've enabled staggered file versioning with no maximum age on my home server.

   _After enabling file versioning, you may notice this minor [quirk](https://forum.syncthing.net/t/why-does-rename-move-put-file-s-in-stversions-dir/2757). It really makes no practical difference, but if you're OCD about that stuff then you may take interest in this [script](https://github.com/artnc/syncthing-dedupe) I wrote._

1. **Optional: Access your home server from the public internet**

   Maybe you want to check out your home server's [Syncthing dashboard](https://docs.syncthing.net/intro/getting-started.html#configuring), or maybe you want to remotely restore some deleted files from your home server's `.stversions`. How do you connect to your server when you're not at home?

   ![Home server](/img/home-server.jpg)

   You'll first need to go home and open ports on your router, whose admin panel is typically accessible at [192.168.0.1](http://192.168.0.1/) or [192.168.1.1](http://192.168.0.1/). Look for the [port forwarding](https://en.wikipedia.org/wiki/Port_forwarding) settings and map the router's port 8384 to your home server's port 8384. The Syncthing dashboard runs on port 8384; you can also open ports for other programs like SSH\*. This wiring step is necessary because all devices on your home network share the same public IP address (e.g. `123.45.67.89`), and so your router needs to know which one of them should handle incoming address-port combinations like `123.45.67.89:8384`.

   _\*If you do decide to expose SSH, either map your server's port 22 to a different port number on your router or edit your server's SSH config to use a port other than 22. This simple security-through-obscurity measure defeats the 99% of login bots that target the default SSH port._

   You can now remotely view your home server's Syncthing dashboard by going to `https://123.45.67.89:8384/` in your web browser. Go into the dashboard settings and set a password so that nobody else will be able to view it.

   One last thing: that IP address is hard to remember and not even guaranteed to stay the same forever! Registering for a free subdomain with a service like [FreeDNS](http://freedns.afraid.org/subdomain/) will let you access your server via something more reasonable like `https://johndoe.jumpingcrab.com:8384/`. FreeDNS works by giving you a cron script for your home server that periodically sends your router's current IP address to the [FreeDNS DNS servers](https://en.wikipedia.org/wiki/RAS_syndrome), which in turn map it to a human-readable domain name.

In the end, this is all a bit of legwork but definitely worth the peace of mind. I've found my holy grail of a sync/backup solution that's free (in both senses), secure, fast, simple, and robust.
