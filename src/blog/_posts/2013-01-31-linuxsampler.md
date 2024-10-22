---
tags: How-to Linux Music
title: How to Connect a MIDI Keyboard to LinuxSampler
---

A couple years ago I went shopping for a MIDI keyboard based on price and key weighting, with no consideration given to audio quality. I figured that'd be lousy anyway, and on Windows I had used an acoustic modeling program called Pianoteq that did a decent enough job of replacing the stock samples.

Unable to find a similar modeler for Linux[^pianoteq], I decided to go with [LinuxSampler](http://www.linuxsampler.org/about.html). Unfortunately, none of the installation guides I could find online worked for me. The process of getting the LinuxSampler engine, either of the two available frontends, JACK, and my keyboard to work together slowly degenerated into randomly guessing different permutations of steps to take. Eventually I hit upon the magic formula for each of the two official frontends, JSampler (preferred) and QSampler.

[^pianoteq]: Pianoteq has become [available](http://www.pianoteq.com/pianoteq4) for Linux since the time this post was written.

Here I assume you have the LinuxSampler engine with all the required libraries installed already, and that all you need now is to get JSampler and/or QSampler to detect your MIDI controller.

![](/img/linuxsampler-jsampler.jpg)

## JSampler

1. Disconnect the USB cable connecting the keyboard/controller to the computer.
1. Run `linuxsampler`
1. Open Fantasia via `java -jar Fantasia-0.9.jar`
1. Run `qjackctl`
1. (Optional) Load your custom LSCP script into JSampler. [Here's mine](https://github.com/artnc/dotfiles/blob/master/linuxsampler/jsampler_settings.lscp).
1. With the keyboard powered off, plug in the USB or MIDI cable.
1. In qjackctl, click Connect and link "USB MIDI" output with "LinuxSampler" input (see screenshot below).
1. Power on the keyboard.
1. Close qjackctl.

![](/img/linuxsampler-qjackctl.jpg)

## QSampler

1. Run `linuxsampler`
1. Run `qsampler`
1. Power on the keyboard and connect the USB cable.
1. Run `qjackctl`
1. In qjackctl, click Connect and link "USB MIDI" output with "LinuxSampler" input (see screenshot above).
1. Close qjackctl.
