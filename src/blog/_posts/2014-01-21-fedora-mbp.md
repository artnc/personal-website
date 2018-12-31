---
h1: Fedora Linux on the MacBook Pro
layout: post
pagetitle: Fedora Linux on the MacBook Pro
tags: ["linux"]
pagemap: true
---
I recently came into ownership of a late-2013 MacBook Pro with Retina display. About an hour every morning of my first week with this laptop was spent extinguishing Linux fires that had somehow sprung up overnight. This post is a summary of the progress I've made on those issues in roughly decreasing order of importance. It was originally written for Fedora 20 but should still mostly work.

## WiFi doesn't work

You need to download wireless drivers from the Internet to get wireless working, but the MBP doesn't have an ethernet port. Bit of a catch-22. Unless you have an ethernet-to-USB adapter lying around, the easiest way to get a temporary connection is to tether from your smartphone via USB.

Once connected, run `sudo yum install akmod-wl` and then reboot. I had to also run `modprobe wl` afterward. Wireless should work now.

You can alternatively install kmod-wl instead of akmod-wl if you want. The difference is that kmod drivers are tied to kernel versions, while akmod drivers are recompiled as necessary on boot. Since I'm (probably irrationally) wary of compiling stuff locally, I go the kmod route. The downside is that kmod drivers are typically released a few days after the corresponding kernel version. If you use kmod-wl, just remember to select the second-newest kernel version from the GRUB boot menu until the appropriate kmod-wl update is available.

## CPU idles at 100 &deg;C

Running `su -c "echo -n 1 > /sys/devices/system/cpu/intel_pstate/no_turbo"` nuked my CPU's ability to boil water. Now its temperature rarely goes above 70 &deg;C.

## System resumes immediately after suspend

A once-common scenario: I close the lid, the Apple logo goes dark, and ten seconds later it lights up again. Some rogue device is triggering the wakeup signal.

Run `cat /proc/acpi/wakeup` to get a list of all wakeup devices (my original version shown below). If you're not sure what piece of hardware a Device code represents, you can find out by running `lspci` and looking for the last digits of its Sysfs node.

```text
Device  S-state   Status   Sysfs node
P0P2      S3    *disabled  pci:0000:00:01.0
GFX0      S3    *disabled  pci:0000:01:00.0
PEG1      S3    *disabled  pci:0000:00:01.1
EC        S3    *disabled
GMUX      S3    *disabled  pnp:00:07
HDEF      S3    *disabled  pci:0000:00:1b.0
RP03      S4    *disabled  pci:0000:00:1c.2
ARPT      S4    *disabled  pci:0000:03:00.0
RP04      S4    *disabled  pci:0000:00:1c.3
RP05      S3    *disabled  pci:0000:00:1c.4
XHC1      S3    *enabled   pci:0000:00:14.0
ADP1      S3    *disabled
LID0      S3    *enabled
```

Running `su -c "echo XHC1 > /proc/acpi/wakeup"` for XHC1 and similar for LID0 toggles their states to "disabled". Note that you *cannot* just open `/proc/acpi/wakeup` in a text editor, edit the statuses, and save.

## Stuck at Fedora logo after resume

Occasionally when I woke up my computer, I got stuck with the same splash screen that appears during boot. [This question](https://ask.fedoraproject.org/en/question/38246/fedora-logo-displayed-after-suspendresume/) gives a pretty accurate description of the problem.

Plymouth is the splash screen program. A simple `sudo yum remove plymouth*` followed by `sudo dracut -f` worked for me.

If that doesn't do the trick for you, it's still possible to get to the desktop without rebooting. Switch to a TTY via Ctrl+Alt+F2, log in, run `sudo pkill X`, and switch back via Ctrl+Alt+F1. Note that by default, MBP function keys are swapped with media keys; you may actually need to press Ctrl+Alt+Fn+F2 and Ctrl+Alt+Fn+F1. This method is hardly better than rebooting though, since it wipes out all of your previously open windows.

## "FPDMA QUEUED" errors

Annoying messages like these would often appear repeatedly during boot, making the process take minutes instead of seconds:

```text
ata1.00: failed command: WRITE FPDMA QUEUED
ata1.00: failed command: READ FPDMA QUEUED
```

These went away after I added `echo 1 > /sys/block/sda/device/queue_depth` to a startup script.

## Function keys and media keys are switched

On most keyboards, pressing F5 refreshes the page and pressing Fn+F5 increases the screen brightness or whatever. This is reversed on the MBP, which I would venture to guess is against your preference if you're the kind of masochist who installs Fedora on Apple hardware. You can fix it by adding `echo 2 > /sys/module/hid_apple/parameters/fnmode` to a startup script that runs as root.

## Tapping the touchpad doesn't generate a left-click

Run `synclient TapButton1=1`. This effect isn't permanent, so you should add it to a startup script.

## Thunderbolt ports don't work

Well they supposedly do, but you need to have everything connected before booting Linux. Hot-plugging doesn't work.

## Webcam doesn't work

The Linux kernel version 3.0+ includes the driver for Apple's iSight camera. Unfortunately, newer Apple laptops have a so-called FaceTime HD camera instead, listed as "Broadcom Corporation Device 1570" by `lspci`.

I've scoured the interwebs fairly thoroughly and despite one dubious [report](https://bbs.archlinux.org/viewtopic.php?pid=1139257#p1139257) to the contrary, it seems that FaceTime HD camera support on Linux just doesn't exist yet. The Arch wiki [agrees](https://wiki.archlinux.org/index.php/MacBookPro11,x#Web_cam).

> **Update:** The Arch wiki now links to an [experimental driver](https://github.com/patjak/bcwc_pcie/). I haven't personally tried it.

## Red light in headphone jack always on

Some people have had luck with `amixer set IEC958 off`. I haven't. The red light wastes a few electrons but is otherwise harmless.

> **Update:** My red light has since fixed itself, but thanks to commenter Jonny for this tip below!

> "Try this to disale the red lighht in headphone jack:

> ```
amixer -c 0 sset "IEC958",16 off
```

> Use ```amixer -c 0``` to list your devices. My notebook (MacbootPro9,2) has 3 IEC952 entries, and this is the one that disabled the light."
