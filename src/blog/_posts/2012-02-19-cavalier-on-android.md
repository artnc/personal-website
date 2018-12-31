---
description: A detailed guide for connecting an Android device to the University of Virginia's secure wireless network, cavalier.
h1: Connecting Android to UVa's Cavalier Network
layout: post
pagetitle: Connecting Android to UVa's Cavalier Network
tags: ["linux"]
pagemap: true
---
This method takes about five minutes and has been confirmed by several people to work, despite the lack of official Android support from [ITS](http://its.virginia.edu/mobile/android.html#wireless).

<a href="/img/android-on-cavalier-connected.jpg" class="nounderline" title="HTC myTouch 4G (CyanogenMod 7) connected to cavalier"><img src="/img/android-on-cavalier-connected.jpg" class="right" alt="HTC myTouch 4G (CyanogenMod 7) connected to cavalier"></a>

1. Go to *Settings > Wireless & networks > Wi-Fi settings* and make sure your Android device can detect the cavalier network.

1. Either connect to [wahoo](http://its.virginia.edu/mobile/android.html#wireless) or turn on mobile data. Then open your device's web browser and go to [https://standard.pki.virginia.edu/pkcs12/](https://standard.pki.virginia.edu/pkcs12/)

1. Click OK, fill out the required information, and submit.

1. Your browser will redirect to another page and start downloading a file named `[computing id].p12`. If you get a toast saying that the certificate has been installed, skip to step 7.

1. The default save location might be a folder called something like "Downloads", but you need to change it to `/mnt/sdcard`. Save the file.

1. Go to *Settings > Location > security* and click "Install from SD card" (sometimes called "Install from device storage"). Name your certificate whatever you want.

1. Go back to *Settings > Wireless & networks > Wi-Fi settings* and click on cavalier.

1. Enter these settings. Pay attention to the capitalization of Virginia.EDU!
    <table class="borderless">
      <tr><td>EAP method: </td><td><code>TLS</code></td></tr>
      <tr><td>Phase 2 authentication: </td><td><code>None</code></td></tr>
      <tr><td>CA certificate: </td><td><code>[certificate name]</code></td></tr>
      <tr><td>User certificate: </td><td><code>[certificate name]</code></td></tr>
      <tr><td>Identity: </td><td><code>[lowercase computing id]@Virginia.EDU</code></td></tr>
      <tr><td>Anonymous identity: </td><td><code>[leave blank]</code> </td></tr>
      <tr><td>Password: </td><td><code>[netbadge password]</code></td></tr>
    </table>
  </li>

1. Click Connect. Enter your credential storage password if asked. ([Don't know it?](https://www.google.com/search?q=android+reset+credential+storage+password))

Note that every time you reboot, the cavalier network will be disabled and you will need to repeat step 9. This is a "feature" of Android. You'll also need to repeat the whole process every year when you renew your certificate, just like you do with your computer and other devices.

If you need to connect Linux to cavalier, try [this](http://uvalug.org/wiki/Cavalier_Wireless_with_Network_Manager).
