---
h1: Arch Linux Notes
layout: post
pagetitle: Arch Linux Notes
tags: ["linux"]
comments: true
---
This page is a living document intended to save time for my future self in case the same issues ever crop up again.

Arch is surprisingly stable if you remember the single most important post-install step: subscribe to the official [news feed](https://www.archlinux.org/feeds/news/) for breaking changes!

## Recovering from a bad upgrade

I once ran a `pacman -Syu` that spat out a bunch of errors, probably due to an unfortunate interaction between package versions available at the time. After lazily crossing my fingers and restarting the computer, I got a boot error (of course):

```
Failed to execute /init (error -13)
Starting init: /sbin/init exists but couldn't execute it (error -13)
Starting init: /bin/init exists but couldn't execute it (error -13)
Starting init: /bin/sh exists but couldn't execute it (error -13)
Kernel panic - not syncing: No working init found. Try passing init= option to kernel. See Linux Documentation/init.txt for guidance.
```

Some weeks later I crossed my fingers and ran the upgrade command again, which fixed everything. How do you run commands on a system that you can't even boot into? I followed [this advice](https://bbs.archlinux.org/viewtopic.php?pid=1528537) to use `arch-chroot`. Cue painfully detailed guide to `arch-chroot`:

1. Before turning on the computer, plug in a USB stick with Arch [on it](https://wiki.archlinux.org/index.php/USB_flash_installation_media). Also plug in an ethernet cable if your planned fix requires a connection.

1. Turn on the computer and go into BIOS by hitting some manufacturer-specific key combination after the screen turns on (e.g. `Fn+F2` on my Lenovo laptop). Find the boot priority list and reorder it so that the USB drive has the highest priority. Save, exit, and boot into USB when asked.

1. Now you have a command prompt. This is where you'll be using `arch-chroot`. Pleeease don't blindly run this snippet as a script!

    ```shell
    # First, list all partitions and take note of the one that seems like your computer's root filesystem, e.g. /dev/sda8
    fdisk -l

    # Mount that drive
    mount /dev/sda8 /mnt

    # Enter your computer's root filesystem as root
    arch-chroot /mnt

    # Do whatever's necessary to fix the original problem (in my case, another upgrade attempt)
    pacman -Syu

    # Leave the chroot environment
    exit

    # Unmount the filesystem
    umount /mnt

    # Done!
    reboot
    ```

1. As the computer reboots, go back into BIOS and move GRUB back to highest boot priority. Boot into your hopefully working system and remove the USB drive.

<!-- Note to self: this issue may have arisen just because I installed Clipman and enabled synced selections at some point... -->
<!--
## Unifying the two clipboards

In addition to the regular clipboard that Windows and Mac users are familiar with, Linux also has a selection clipboard that automatically copies text whenever you highlight it. It's extremely annoying to `Ctrl+C` a URL, click on your browser's location bar, and press `Ctrl+V` only to end up re-pasting the existing URL because your browser had highlighted it when you clicked on the location bar.

I installed Clipman, went into its settings, and disabled "Sync selections".
 -->

## Connecting to an L2TP/IPsec VPN

Just to be safe, uninstall all of the following packages: openswan, strongswan, networkmanager-openswan, networkmanager-strongswan, and networkmanager-libreswan. I couldn't get any of these to work. Openswan seems capable but there's no way I'm going to run through [this gauntlet](https://wiki.archlinux.org/index.php/Openswan_L2TP/IPsec_VPN_client_setup) for a single VPN connection if I can avoid it.

Install [networkmanager](https://www.archlinux.org/packages/extra/x86_64/networkmanager/), [libreswan](https://aur.archlinux.org/packages/libreswan/), and [networkmanager-l2tp](https://aur.archlinux.org/packages/networkmanager-l2tp/). (It's important to install networkmanager-l2tp last!) Then add the VPN entry as usual by right-clicking the NetworkManager applet or running `nm-connection-editor`.

When setting up the VPN entry, go into "IPsec Settings" and check "Enable IPsec tunnel to L2TP host". You may also need to uncheck "Perfect Forward Secrecy".

> Update 2017-07-08: Due to a Linux kernel [regression](https://bbs.archlinux.org/viewtopic.php?pid=1713763#p1713763), you supposedly now must also install `linux-lts` and then run `sudo grub-mkconfig`. I still haven't gotten it working, though.

## Using an external hard drive

External HDDs not marketed specifically for Mac are typically formatted as NTFS, the file system used by Windows. It's best to keep NTFS if you ever plan to access your HDD from Windows, in which case you'll need to do a little extra setup for Linux:

```shell
# First, plug the HDD into your computer and verify that it can be detected
lsusb

# Check that the kernel logs contain fairly detailed info about the HDD. If all you see is a few generic lines about a new USB device being detected, try restarting the computer
dmesg | tail -n 20

# List all partitions and find the one that seems like your HDD, e.g. /dev/sdb1
# (Note that NTFS drives might show up as type "fuseblk")
sudo fdisk -l

# Install ntfs-3g, which adds NTFS support to `mount`
sudo pacman -S ntfs-3g

# Create the mount point at /mnt/whatever-name-you-want
sudo mkdir /mnt/seagate

# Mount the partition you found from `fdisk -l`
sudo mount -o rw,user,async -t ntfs-3g /dev/sdb1 /mnt/seagate

# Unmount when done (before you unplug the HDD)
sudo umount /mnt/seagate
```

Make sure to provide `async` as a mount option instead of `sync`! The latter absolutely kills write performance on NTFS; we're talking less than 100 kB/s.

## Fixing audio mute

First of all, make sure you have the `alsa-utils` package installed. It provides two useful programs to keep open while debugging sound issues: `speaker-test -t wav -c 2` plays a looping audio sample, and `alsamixer` shows the current volume and mute status of all audio channels.

Most people online suggest muting via the command `amixer set Master toggle`. This works but has an unfortunate quirk on some systems: running it a second time doesn't actually unmute!

Muting Master mutes all channels, but unmuting Master unmutes only the Master channel. That's a problem if you have other audio channels that depend on Master, e.g. Speaker and Headphone. The `pulseaudio` package provides `pactl`, an alternative to `amixer` that doesn't suffer from the same bug. Run `pactl set-sink-mute 0 toggle` to toggle the mute status of all channels in unison.

In my i3 config, I have that command bound to my keyboard's mute button like so:

```shell
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle
```

## Booting UEFI with an existing EFI partition

GRUB was presenting me with its own slow-ass [shell](https://www.linux.com/learn/how-rescue-non-booting-grub-2-linux) instead of an OS selection menu. The [problem](https://bbs.archlinux.org/viewtopic.php?pid=1348012#p1348012) was that the live USB had installed some rather important files into the root filesystem's `/boot` folder instead of the EFI partition.

I had mistakenly been under the impression that mounting the existing EFI partition (used by Windows) to the root filesystem's `/boot` was unnecessary because both already existed and had stuff in them. [Reinstalling](https://bbs.archlinux.org/viewtopic.php?pid=1641965#p1641965) with the partition mounted fixed things.

## Ditching GRUB (only for UEFI systems)

GRUB is the kitchen sink bootloader. Systemd comes with its own UEFI bootloader that's much simpler and works perfectly fine if all you need is an OS selection menu. As explained in the [guide](https://wiki.archlinux.org/index.php/systemd-boot), just enable `systemd-boot` and create the two files `arch.conf` and `loader.conf`.

## Fixing the default LaTeX font

Rendering a LaTeX file to PDF works fine after installing `texlive-core`, but what's up with the fugly text? Zooming in reveals that the bitmap version of Computer Modern is being used. We need to specify an infinitely scalable vector font instead.

The first step of the [fix](https://bbs.archlinux.org/viewtopic.php?pid=523453#p523453) is to enable Latin Modern, the widely accepted successor to Computer Modern:


```shell
updmap --enable Map=lm.map
```

Then add this to the preamble of your LaTeX document:

```latex
\usepackage{lmodern}
```

Generate the PDF again, and font rendering should be fixed.

## Getting Intel Wireless 8260 card to work

Trying to [activate](https://wiki.archlinux.org/index.php/Wireless_network_configuration) my WiFi card with `ip link set wlp4s0 up` failed with a vague `RTNETLINK answers: Input/output error` message. Turns out that version 22 of the Linux kernel's firmware for my particular WiFi card was [problematic](https://bbs.archlinux.org/viewtopic.php?pid=1590387#p1590387). You can see what firmware version you're on by running `dmesg | grep 'iwlwifi.*loaded'`.

The solution was to force Linux to use the previous version of the firmware by [disabling](https://ubuntuforums.org/showthread.php?t=2342945&p=13568896#post13568896) the latest version. As root:

```shell
# Stop kernel module "iwlwifi", which will need to be restarted. (Not sure what iwlmvm is, but `rmmod iwlwifi` complains that it's in the way)
rmmod iwlmvm
rmmod iwlwifi

# Rename the firmware file so that Linux won't find it
cd /lib/firmware
mv iwlwifi-8000C-22.ucode iwlwifi-8000C-22.bak

# Re-enable modules
modprobe iwlwifi
modprobe iwlmvm
```

Since I was setting up Arch at my office without the luxury of ethernet, I actually ended up having to go through this process twice: once on the live USB and again on my laptop's instance of Arch.

## Manually connecting to a WPA network

TLDR of the Arch [guide](https://wiki.archlinux.org/index.php/Wireless_network_configuration) (run as root):

```shell
ip link set wlp4s0 up
wpa_supplicant -D nl80211,wext -i wlp4s0 -c <(wpa_passphrase "ssid" "password")
# (Switch to another TTY at this point)
dhchpd
ping 8.8.8.8
```

## Supporting true color in xfce4-terminal

Set `TERM=xterm-256color` in your `.zshrc` / `.bashrc`.

## Making Android Studio / React Native work

I was trying to set up React Native, which involves setting up Android Studio. Everything went well up until `react-native run-android`:

```
java.io.IOException: Cannot run program "/home/art/Android/Sdk/build-tools/23.0.1/aapt": error=2, No such file or directory
```

The solution is to enable the [multilib repository](https://wiki.archlinux.org/index.php/multilib) and then install [some packages](https://medium.com/@bpdp/undocumented-manual-of-react-native-for-64-bit-linux-5a7992ae3008):

```shell
pacman -S lib32-gcc-libs lib32-glibc lib32-libstdc++5 lib32-ncurses lib32-zlib
```

If your `JAVA_HOME` environment variable is unset, you may also need to set it to the grandparent directory of the file found by `locate tools.jar`. For example:

```shell
export JAVA_HOME=/opt/android-studio/jre
```

## Multi-monitor on Thinkpad P51

Using the default `nouveau` graphics driver results in `xrandr` freezing with an external monitor plugged in. I still haven't gotten the DisplayPort ports to work, but here's my solution for VGA/DVI:

1. Install `nvidia` package
1. Uninstall `xf86-video-nouveau` if installed
1. Reboot computer. In BIOS, switch from "Hybrid Graphics" to "Discrete Graphics"

Fonts might look huge in i3 after switching to `nvidia`; restarting i3 with `$mod + Shift + R` fixes it.

## Adding Thai font support

Install `fonts-tlwg` (AUR). It looks perfectly fine and just works. I first tried `ttf-ms-win10` but gave up on getting all of my Windows fonts to the same versions expected by the PKGBUILD.

## My setup

- App launcher: dmenu
- AUR helper: pacaur
- Clipboard manager: xfce4-clipman
- Editor: subl3/nano
- File manager: thunar
- Image viewer: ristretto
- Password manager: keepassx2
- Shell: zsh
- Status bar: i3blocks
- Terminal multiplexer: tmux
- Terminal: xfce4-terminal
- Wallpaper: feh
- Window manager: i3
