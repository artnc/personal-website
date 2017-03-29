---
h1: Arch Linux Notes
layout: post
pagetitle: Arch Linux Notes
tags: []
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

## Using an external hard drive

External HDDs not marketed specifically for Mac are typically formatted as NTFS, the file system used by Windows. It's best to keep NTFS if you ever plan to access your HDD from Windows, in which case you'll need to do a little extra setup for Linux:

```bash
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

## Supporting true color in xfce4-terminal

Set `TERM=xterm-256color` in your `.zshrc` / `.bashrc`.

## Adding Thai font support

Install `fonts-tlwg` (AUR). It looks perfectly fine and just works. I first tried `ttf-ms-win10` but gave up on getting all of my Windows fonts to the same versions expected by the PKGBUILD.

## My setup

- App launcher: dmenu
- AUR helper: pacaur
- Clipboard manager: xfce4-clipman
- Editor: subl3/neovim
- File manager: thunar/ranger
- Image viewer: viewnior
- Password manager: keepassx2
- Shell: zsh
- Status bar: i3blocks
- Terminal multiplexer: tmux
- Terminal: xfce4-terminal
- Wallpaper: feh
- Window manager: i3
