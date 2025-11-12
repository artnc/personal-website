---
ogimage: /img/arch.png
tags: Linux
title: Arch Linux Notes
---

This page is a living document intended to save time for my future self in case the same issues ever crop up again. It's based on my experience with running Arch on a [Raspberry Pi 2](https://archlinuxarm.org/platforms/armv7/broadcom/raspberry-pi-2), a Lenovo Flex 4, a ThinkPad P50, a ThinkPad P51, and a GMKtec NucBox M2 Pro S.

Arch is surprisingly stable if you remember the single most important post-install step: subscribe to the official [news feed](https://www.archlinux.org/feeds/news/) for breaking changes!

![Arch screenshot](/img/arch.png)

### OS

- [Installing Arch via `archinstall` wizard](#installing-arch-via-archinstall-wizard)
- [Refreshing the mirror list](#refreshing-the-mirror-list)
- [Disabling `-debug` packages](#disabling--debug-packages)
- [Recovering from a bad upgrade](#recovering-from-a-bad-upgrade)
- [Installing from PKGBUILD](#installing-from-pkgbuild)
- [Using an external hard drive](#using-an-external-hard-drive)
- [Encrypting an external hard drive](#encrypting-an-external-hard-drive)
- [Freeing up disk space](#freeing-up-disk-space)
- [Increasing the file watch limit](#increasing-the-file-watch-limit)
- [Booting UEFI with an existing EFI partition](#booting-uefi-with-an-existing-efi-partition)
- [Ditching GRUB (only for UEFI systems)](#ditching-grub-only-for-uefi-systems)
- [Suspending after inactivity](#suspending-after-inactivity)
- [Switching to Linux LTS](#switching-to-linux-lts)
- [Booting into USB on GMKtec NucBox](#booting-into-usb-on-gmktec-nucbox)

### Network

- [Manually connecting to a WPA network](#manually-connecting-to-a-wpa-network)
- [`ping` works but `curl` doesn't](#ping-works-but-curl-doesnt)
- [NTP active but not syncing](#ntp-active-but-not-syncing)
- [Fixing iptables unknown options](#fixing-iptables-unknown-options)
- [Port 53 already in use](#port-53-already-in-use)
- [Fixing slow pip downloads](#fixing-slow-pip-downloads)
- [Connecting to an L2TP/IPsec VPN](#connecting-to-an-l2tp-ipsec-vpn)
- [Getting Intel Wireless 8260 card to work](#getting-intel-wireless-8260-card-to-work)

### Display

- [Fixing the default LaTeX font](#fixing-the-default-latex-font)
- [Supporting true color in xfce4-terminal](#supporting-true-color-in-xfce4-terminal)
- [Multi-monitor on ThinkPad P51](#multi-monitor-on-thinkpad-p51)
- [Huge fonts with NVIDIA driver](#huge-fonts-with-nvidia-driver)
- [Ignoring GTK theme in Firefox](#ignoring-gtk-theme-in-firefox)
- [Adding Thai font support](#adding-thai-font-support)

### Miscellaneous

- [Pairing Bluetooth headphones](#pairing-bluetooth-headphones)
- [Fixing audio mute](#fixing-audio-mute)
- [Pacman color option unrecognized](#pacman-color-option-unrecognized)
- [Fixing Flatpak Steam](#fixing-flatpak-steam)
- [Fixing Android Studio](#fixing-android-studio)
- [My setup](#my-setup)

## Installing Arch via `archinstall` wizard

One weird trick Arch devs don't want you to know: Arch comes with an [installation wizard](https://archinstall.archlinux.page/installing/guided.html). It's barely documented (by Arch wiki standards) and never even mentioned in the official installation guide.

Fair enough, you should probably have some idea of what you're doing before taking shortcuts. I've installed Arch enough times by now that I know what partitions are and exactly how I want them set up, but I'm not interested in figuring out such rarely used commands for the dozenth time.

Definitely don't be _too_ lazy by blindly accepting the defaults. There are a few important non-default things to set up during `archinstall` that are more painful to try doing later:

- Create a root password and non-root user
- Create partitions encrypted via LUKS
- Copy your USB installer's WiFi connection settings

## Refreshing the mirror list

By default, your Arch installation will never update its own list of mirrors (software package download sources). This is bad because these volunteer-run mirrors come and go over the years, and the fastest one today will not remain so forever. [Reflector](https://wiki.archlinux.org/title/Reflector) helps you periodically generate a fresh list of mirrors sorted by speed:

```shell
sudo reflector --latest 10 --protocol https --save /etc/pacman.d/mirrorlist --sort rate
```

## Disabling `-debug` packages

In early 2024, I noticed that installing `foobar` would also end up installing `foobar-debug` by default. You can disable that new behavior by [editing](https://bbs.archlinux.org/viewtopic.php?pid=2150180#p2150180) `/etc/makepkg.conf` to specify `!debug` instead of `debug`.

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

## Installing from PKGBUILD

Problem: A `libreswan` update broke compatibility with `networkmanager-l2tp`. Downgrading `libreswan` (AUR) via `downgrade` wasn't an option since I aggressively clear my pacman cache, and after a week I got tired of waiting for the `networkmanager-l2tp` [fix](https://github.com/nm-l2tp/NetworkManager-l2tp/commit/3c6ccfe331e65c7af8be4df78cac67c030e96958) to land in Arch's official repo.

Solution: Clone the `libreswan` repo to `/tmp`, `cd` into it, `git reset --hard` to the last compatible version, and run `makepkg -si` to build and install.

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

## Encrypting an external hard drive

Or if you're sure you'll only ever want to use your HDD with Linux, you can get rid of NTFS and reformat the drive with full-disk encryption via LUKS:

```shell
# Determine your HDD's device name, e.g. sda1
lsblk

# Unmount HDD if mounted
sudo umount /dev/sda1

# Optional: zero out the HDD for peace of mind
sudo dd if=/dev/zero of=/dev/sda1 bs=4M status=progress

# Format HDD (choose a strong password and don't lose it)
sudo cryptsetup luksFormat /dev/sda1

# Open container and invent a mapper name for it, e.g. seagate
sudo cryptsetup luksOpen /dev/sda1 seagate

# Create filesystem
sudo mkfs.ext4 /dev/mapper/seagate

# Mount filesystem at empty directory of your choosing
sudo mkdir -p /mnt/seagate
sudo mount /dev/mapper/seagate /mnt/seagate

# Give yourself ownership of the filesystem (root by default)
sudo chown -R art:art /mnt/seagate

# To unmount, first unmount the mapper and then close the container
sudo umount /dev/mapper/seagate
sudo cryptsetup luksClose seagate
```

## Freeing up disk space

When uninstalling packages, always use `pacman -Rs` to include would-be orphans.

Pacman doesn't delete old package versions, so you'll need to [do so yourself](https://wiki.archlinux.org/index.php/Pacman#Cleaning_the_package_cache) after package upgrades:

```shell
$ paccache -r
==> finished: 523 packages removed (disk space saved: 1.75 GiB)
```

[Pacgraph](http://kmkeen.com/pacgraph/) shows your largest installed packages, which you can then remove if no longer needed.

The systemd journal can grow up to 4 GiB. If you don't need all those logs, you can [cap it to a lower value](https://wiki.archlinux.org/index.php/Systemd#Journal_size_limit).

I had Docker for a while and later decided to uninstall it. Deleting `/var/lib/docker` freed up 8.1 GB.

## Increasing the file watch limit

Many applications that watch your filesystem for changes can hit the OS's (usually rather small) default limit on the number of files that can be simultaneously watched. I've personally run into this issue with Android Studio, Webpack, Watchman, and Syncthing.

Consider this the missing step in the Arch setup guide: drastically [bumping up](https://unix.stackexchange.com/a/13757) the inotify watch limit.

> <span class="badge" title="2025-11-12">Update</span> Arch now seems to set a high limit by default, 524288 on a new install.

## Booting UEFI with an existing EFI partition

GRUB was presenting me with its own slow-ass [shell](https://www.linux.com/learn/how-rescue-non-booting-grub-2-linux) instead of an OS selection menu. The [problem](https://bbs.archlinux.org/viewtopic.php?pid=1348012#p1348012) was that the live USB had installed some rather important files into the root filesystem's `/boot` folder instead of the EFI partition.

I had mistakenly been under the impression that mounting the existing EFI partition (used by Windows) to the root filesystem's `/boot` was unnecessary because both already existed and had stuff in them. [Reinstalling](https://bbs.archlinux.org/viewtopic.php?pid=1641965#p1641965) with the partition mounted fixed things.

## Ditching GRUB (only for UEFI systems)

GRUB is the kitchen sink bootloader. Systemd comes with its own UEFI bootloader that's much simpler and works perfectly fine if all you need is an OS selection menu. As explained in the [guide](https://wiki.archlinux.org/index.php/systemd-boot), just enable `systemd-boot` and create the two files `arch.conf` and `loader.conf`.

## Suspending after inactivity

In `xfce4-power-manager-settings` I specified that my laptop should go to sleep after an hour of inactivity, but that setting never seemed to work. The fix is to just edit one line in one file, as described [here](https://askubuntu.com/a/674720).

## Switching to Linux LTS

This is normally unnecessary but did fix a problem I had on my Thinkpad P51: after upgrading my system in September 2024 for the first time in several months, resume from suspend would reliably greet me with a screen full of [errors](https://en.mihaly4.ru/arch-linux-nvidia-suspend-hibernation) like "Fixing recursive fault but reboot is needed" and "BUG: scheduling while atomic: irq/148-nvidia..."

I switched to the more stable LTS version of Linux by backing up `/boot/initramfs-linux-fallback.img` `/boot/initramfs-linux.img` `/boot/vmlinuz-linux` to somewhere in my home directory, deleting those files to make space in `/boot`, installing `linux-lts` and `nvidia-lts` via pacman, editing `/boot/loader/entries/arch.conf` (see [above](#ditching-grub-only-for-uefi-systems)) to reference the newly created `-lts` files inside `/boot`, and restarting the computer.

## Booting into USB on GMKtec NucBox

I flashed Arch onto a USB drive and set it to highest boot priority in BIOS, but that setting kept getting ignored. Finally I found a [solution](https://www.reddit.com/r/techsupport/comments/12xd7nf/comment/jhjl0un/) deep in the bowels of Reddit: flash Arch onto _two_ USB drives and plug them both in. Weird AF indeed.

<!-- Note to self: this issue may have arisen just because I installed Clipman and enabled synced selections at some point... -->
<!--
## Unifying the two clipboards

In addition to the regular clipboard that Windows and Mac users are familiar with, Linux also has a selection clipboard that automatically copies text whenever you highlight it. It's extremely annoying to `Ctrl+C` a URL, click on your browser's location bar, and press `Ctrl+V` only to end up re-pasting the existing URL because your browser had highlighted it when you clicked on the location bar.

I installed Clipman, went into its settings, and disabled "Sync selections".
 -->

## Manually connecting to a WPA network

TLDR of the Arch [guide](https://wiki.archlinux.org/index.php/Wireless_network_configuration) (run as root):

```shell
ip link set wlp4s0 up # WiFi interface name `wlp4s0` obtained from `ip a`
wpa_supplicant -D nl80211,wext -i wlp4s0 -c <(wpa_passphrase "My WiFi SSID" "p4ssw0rd")
# (Switch to another TTY at this point)
dhcpcd
ping 8.8.8.8
```

My home WiFi and/or my Raspberry Pi's WiFi setup are pretty flaky, so I run cron as root to force a reconnect every day:

```
0 9 * * * killall dhcpcd wpa_supplicant; sleep 5; wpa_supplicant -D nl80211,wext -i wlan0 -c <(wpa_passphrase "My WiFi SSID" "p4ssw0rd") & sleep 20; dhcpcd &
```

## `ping` works but `curl` doesn't

Pinging `8.8.8.8` worked, but pinging or curling `google.com` didn't. I opened my `/etc/resolv.conf` and saw this:

```
# Generated by resolvconf
search tail39f21.ts.net
nameserver 100.100.100.100
```

Looks like Tailscale [overwrote](https://tailscale.com/kb/1235/resolv-conf) this file. I found another helpfully named file `/etc/resolv.pre-tailscale-backup.conf` with these contents:

```
# Generated by NetworkManager
nameserver 1.1.1.1
nameserver 8.8.8.8
nameserver 4.2.2.2
```

Adding those entries back to `/etc/resolv.conf` fixed my DNS... temporarily. Within a few seconds, the file reverted to its previous state.

The permanent fix is to uninstall `resolvconf` (which I had apparently installed as a dependency of `netctl`), [start and enable](https://wiki.archlinux.org/title/Systemd-resolved#Configuration) `systemd-resolved` (which was even installed already but disabled?), [symlink](https://wiki.archlinux.org/title/Systemd-resolved#DNS) `/etc/resolv.conf`, and [restart everything](https://tailscale.com/kb/1188/linux-dns). When this happened on my Raspberry Pi, I also had to restart `systemd-networkd`. Now DNS works and my `/etc/resolv.conf` looks like this:

```
nameserver 127.0.0.53
options edns0 trust-ad
search [REDACTED].ts.net
```

## NTP active but not syncing

My [UPS](https://en.wikipedia.org/wiki/Uninterruptible_power_supply) battery died and I finally had to shut down my Raspberry Pi after several years of continuous uptime. When I turned it back on, I noticed that the time as shown by `date` was several years off. I manually corrected it:

```
sudo timedatectl set-time '2024-10-23 04:41:10'
```

Why was the time wrong in the first place, though? `timedatectl` showed that [NTP](https://en.wikipedia.org/wiki/Network_Time_Protocol) syncing was active but not affecting my system clock:

```
System clock synchronized: no
              NTP service: active
```

My `/etc/systemd/network` contained a file called `eth0.network` but no file for WiFi. [Adding one](https://bbs.archlinux.org/viewtopic.php?pid=2057633#p2057633) fixed the problem.

## Fixing iptables unknown options

The default version of `iptables` drops support for a command-line option that Docker uses:

```
docker: Error response from daemon: driver failed programming external connectivity on endpoint tender_volhard (954d664336eb5ea7b2c7f808889b3033977b45f53f99ba38bbc66bfcf14a61ef):  (iptables failed: iptables --wait -t nat -A DOCKER -p tcp -d 0/0 --dport 80 -j DNAT --to-destination 172.17.0.2:80 ! -i docker0: iptables v1.8.2 (legacy): unknown option "--dport"
Try `iptables -h' or 'iptables --help' for more information.
```

[Switching](https://github.com/moby/moby/issues/38759#issuecomment-473909447) to `iptables-nft` restores the legacy `--dport` option. Note that whenever you update the Linux kernel, the option may become unavailable again until the next reboot.

## Port 53 already in use

When I tried to set up [Pi-hole](https://pi-hole.net/) in Docker, I got this error:

```
Error response from daemon: failed to set up container networking: driver failed programming external connectivity on endpoint pihole (851ce571120db7262a96ab24f4c019005a37094543b008cd1ec90baa35b392cf): failed to bind host port for 0.0.0.0:53:172.19.0.2:53/tcp: address already in use
```

The [solution](https://discourse.pi-hole.net/t/update-what-to-do-if-port-53-is-already-in-use/52033) is to set `DNSStubListener=no` in `/etc/systemd/resolved.conf` and then `sudo systemctl restart systemd-resolved`.

## Fixing slow pip downloads

One day my `pip install` suddenly became comically slow, seemingly on the order of 10 kB/s. A `pip -vvv` revealed that it was hanging on "Starting new HTTPS connection (1) pypi.org", which led me to [this post](https://www.reddit.com/r/bashonubuntuonwindows/comments/8rplxw/python_pip_takes_forever_on_wsl/e0twr6z/?utm_source=reddit&utm_medium=web2x&context=3) that correctly identified my issue: pip tried and failed to connect using multiple IPv6 addresses until it finally gave up and fell back to IPv4.

My workaround was to simply [disable IPv6](https://wiki.archlinux.org/index.php/IPv6#Disable_functionality) in kernel params 🤷

## Connecting to an L2TP/IPsec VPN

Just to be safe, uninstall all of the following packages: openswan, strongswan, networkmanager-openswan, networkmanager-strongswan, and networkmanager-libreswan. I couldn't get any of these to work. Openswan seems capable but there's no way I'm going to run through [this gauntlet](https://wiki.archlinux.org/index.php/Openswan_L2TP/IPsec_VPN_client_setup) for a single VPN connection if I can avoid it.

Install [networkmanager](https://www.archlinux.org/packages/extra/x86_64/networkmanager/), [libreswan](https://aur.archlinux.org/packages/libreswan/), and [networkmanager-l2tp](https://aur.archlinux.org/packages/networkmanager-l2tp/). (It's important to install networkmanager-l2tp last!) Then add the VPN entry as usual by right-clicking the NetworkManager applet or running `nm-connection-editor`.

When setting up the VPN entry, go into "IPsec Settings" and check "Enable IPsec tunnel to L2TP host". You may also need to uncheck "Perfect Forward Secrecy".

> <span class="badge" title="2017-07-08">Update</span> Due to a Linux kernel [regression](https://bbs.archlinux.org/viewtopic.php?pid=1713763#p1713763), you supposedly now must also install `linux-lts` and then run `sudo grub-mkconfig`. I still haven't gotten it working, though.

> <span class="badge" title="2018-12-26">Update</span> I've given up on libreswan and networkmanager. Here's a [guide](/l2tp-ipsec) for openswan.

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

## Supporting true color in xfce4-terminal

Set `TERM=xterm-256color` in your `.zshrc` / `.bashrc`.

## Multi-monitor on ThinkPad P51

Using the default `nouveau` graphics driver results in `xrandr` freezing with an external monitor plugged in. I still haven't gotten the DisplayPort ports to work, but here's my solution for VGA/DVI:

1. Install `nvidia` package
1. Uninstall `xf86-video-nouveau` if installed
1. Reboot computer. In BIOS, switch from "Hybrid Graphics" to "Discrete Graphics"

However, fonts might look huge in some apps after switching to `nvidia`...

## Huge fonts with NVIDIA driver

The proprietary `nvidia` driver misdetects my laptop screen's DPI for some reason. This can be fixed by adding the command below to `~/.xinitrc` and then rebooting.

```shell
# Replace `DP-2` with whatever `xrandr` says your laptop screen is called
xrandr --output DP-2 --dpi 96
```

A possibly related issue is that X fails to identify the laptop screen as the primary screen (even when no external monitors are connected), causing i3status to hide its notification area. This can be fixed by appending `--primary` to the command above.

## Ignoring GTK theme in Firefox

In `xfce4-appearance-settings` I've selected the Adwaita-dark GTK theme. It looks decent everywhere except in Firefox, which will render dark scrollbars and form controls on otherwise light pages.

To force Firefox to use the default (light) Adwaita theme, I've created an executable `/usr/bin/local/firefox` script with these contents:

```shell
#!/usr/bin/env bash
GTK_THEME=Adwaita /usr/bin/firefox
```

Make sure `/usr/bin/local` appears before `/usr/bin` in your PATH.

## Adding Thai font support

Install `fonts-tlwg` from the AUR. It looks perfectly fine and just works. I first tried `ttf-ms-win10` but gave up on getting all of my Windows fonts to the same versions expected by the PKGBUILD.

## Pairing Bluetooth headphones

Steps distilled from the [Arch wiki](https://wiki.archlinux.org/title/Bluetooth) and [this answer](https://askubuntu.com/a/1120106):

```shell
pacman -S bluez bluez-utils blueman pulseaudio-bluetooth
modprobe btusb
systemctl enable bluetooth.service
pulseaudio -k
blueman-applet
```

## Fixing audio mute

First of all, make sure you have the `alsa-utils` package installed. It provides two useful programs to keep open while debugging sound issues: `speaker-test -t wav -c 2` plays a looping audio sample, and `alsamixer` shows the current volume and mute status of all audio channels.

Most people online suggest muting via the command `amixer set Master toggle`. This works but has an unfortunate quirk on some systems: running it a second time doesn't actually unmute!

Muting Master mutes all channels, but unmuting Master unmutes only the Master channel. That's a problem if you have other audio channels that depend on Master, e.g. Speaker and Headphone. The `pulseaudio` package provides `pactl`, an alternative to `amixer` that doesn't suffer from the same bug. Run `pactl set-sink-mute 0 toggle` to toggle the mute status of all channels in unison.

In my i3 config, I have that command bound to my keyboard's mute button like so:

```shell
bindsym XF86AudioMute exec --no-startup-id pactl set-sink-mute 0 toggle
```

## Pacman color option unrecognized

A [pacman bug](https://lists.archlinux.org/pipermail/pacman-dev/2018-June/022561.html) causes this error when installing AUR packages with pacaur:

```shell
/usr/bin/pacman: unrecognized option '--color never'
```

To [fix](https://www.reddit.com/r/archlinux/comments/8o5ol0/error_using_pacman_usrbinpacman_unrecognized/e0dlfaf), uncomment `Color` in `/etc/pacman.conf`.

## Fixing Flatpak Steam

I installed Steam via Flatpak as [documented](https://wiki.archlinux.org/index.php/steam#Alternative_Flatpak_installation) in the Arch wiki, which initially worked fine. However, I got this error the second time I tried running Steam:

```shell
$ flatpak run com.valvesoftware.Steam
**
flatpak:ERROR:libglnx/glnx-shutil.c:155:mkdir_p_at_internal: assertion failed: (!did_recurse)
Bail out! flatpak:ERROR:libglnx/glnx-shutil.c:155:mkdir_p_at_internal: assertion failed: (!did_recurse)
zsh: abort (core dumped)  flatpak run com.valvesoftware.Steam
```

It looked like some symlink targets were missing...

```shell
$ ls -AGl ~/.var/app/com.valvesoftware.Steam
total 8
lrwxrwxrwx 1 art    6 Jul 28 02:38 cache -> .cache
lrwxrwxrwx 1 art    7 Jul 28 02:38 config -> .config
drwxr-xr-x 2 art 4096 Jul 28 02:38 config.old
lrwxrwxrwx 1 art   12 Jul 28 02:38 data -> .local/share
drwxr-xr-x 2 art 4096 Jul 28 02:38 .ld.so
```

Pointing them to their counterparts in my home directory [solved the issue](https://github.com/flatpak/flatpak/issues/1998#issuecomment-415386819):

```shell
$ ln -sf ~/.cache ~/.var/app/com.valvesoftware.Steam/cache

$ ln -sf ~/.config ~/.var/app/com.valvesoftware.Steam/config

$ ln -sf ~/.local/share ~/.var/app/com.valvesoftware.Steam/data

$ ls -AGl ~/.var/app/com.valvesoftware.Steam
total 8
lrwxrwxrwx 1 art   16 Jul 29 02:02 cache -> /home/art/.cache
lrwxrwxrwx 1 art   17 Jul 29 02:02 config -> /home/art/.config
drwxr-xr-x 2 art 4096 Jul 28 02:38 config.old
lrwxrwxrwx 1 art   22 Jul 29 02:02 data -> /home/art/.local/share
drwxr-xr-x 2 art 4096 Jul 28 02:38 .ld.so
```

## Fixing Android Studio

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

If you get errors like the one below when running Android Studio 3's emulator, [this](https://bbs.archlinux.org/viewtopic.php?pid=1747748#p1747748) and/or [this](https://stackoverflow.com/a/42686791) should fix it.

```shell
Emulator: libGL error: unable to load driver: i965_dri.so
```

## My setup

On all Arch installations:

```shell
pacman -S bc fd-rs fzf git htop ncdu ntfs-3g python-pre-commit rclone reflector ripgrep rsync sudo syncthing tmux words zsh zsh-syntax-highlighting
```

On graphical Arch installations:

```shell
pacman -S alacritty dmenu docker easystroke evince feh firefox gimp i3-wm i3blocks i3blocks-contrib-git i3lock i3status imagemagick jq keepassxc network-manager-applet numlockx pacgraph scrot shellcheck-bin sublime-text-dev thunar xfce4-goodies xfce4-power-manager
```

[My .zshrc and other dotfiles](https://github.com/artnc/dotfiles)
