---
title: How to Ring Calls and Vibrate Notifications on Android
---

I want calls to ring audibly, and I want notifications to vibrate silently.

Is that too much to ask for? Recent Android versions make this exceedingly reasonable configuration nearly impossible to implement.

> Update 2023-12-28: Android 14 finally [fixed](https://chromeunboxed.com/android-14-notification-ringtone-split-in-two) this problem by providing separate settings for ringtone volume and notification volume! Just set your notification volume to 0, set your ringtone volume to something above 0, and stop reading this blog post.

## The solution

Android's native [Do Not Disturb](https://support.google.com/android/answer/9069335?hl=en) (henceforth "DND") feature is the perfect solution except that it doesn't allow notifications to vibrate. So we'll roll that feature ourselves:

1. Enable DND and keep it turned on forever
1. Allow calls to interrupt DND. On Android 11, this option is at `Settings > Sound > Do Not Disturb > People > Calls`
1. Install [Tasker](https://play.google.com/store/apps/details?id=net.dinglisch.android.taskerm)
1. Create a new "Do Disturb" profile that overrides the notification behavior of your permanent DND by triggering a 200ms vibration whenever a new notification arrives (optionally with your waking hours as a second constraint if you're an extremely light sleeper like me):

   ![](/img/do-disturb.png)

I've been using this setup for six months now. The only downside is that I can no longer identify apps by their custom vibration patterns, but that's a relatively small price to pay.

---

## The non-solutions

My path to the solution above is littered with the bodies of many failed attempts, some documented below. Note that Android has two subtly annoying limitations to work around:

- Vibrate mode achieves the desired notification behavior, but Android offers no way to ring calls audibly in vibrate mode
- DND mutes notifications and allows calls to ring audibly, but Android offers no way to both vibrate and mute notifications during DND

## Faking vibrate mode via inaudible notifications

Strategy: Remove notification audio directly.

1. Permanently disable both DND and vibrate mode
1. Roll your own vibrate mode by going into `Sound` settings and changing the `Default notification sound` to the `None` option (which might be located inside `My Sounds`)

Fatal flaw: Some apps use their own custom notification sounds, which still play.

## Overriding system volume via PagerDuty

Strategy: Give up hope on ringing all calls audibly and settle for ringing only PagerDuty calls audibly.

1. Permanently enable vibrate mode
1. Go into the PagerDuty app's settings and enable system volume override

Fatal flaw: That override option just flat out doesn't work on my Pixel 2.

## Temporarily unmuting the ringer via Tasker

Strategy: Stay in vibrate mode but use Tasker to temporarily disable vibrate mode during calls.

1. Permanently enable vibrate mode
1. Create a Tasker profile that disables vibrate mode whenever a call comes in and reenables vibrate mode when the call ends

Fatal flaw: Android doesn't actually let you [leave vibrate mode](http://tasker.wikidot.com/alwaysringonimportantcontact) while ringing?!

## Ringing on the media channel via Tasker

Strategy: Stay in vibrate mode and use Tasker to "ring" calls by simply playing an MP3 file that you specify.

1. Permanently enable vibrate mode
1. Follow [these instructions](http://tasker.wikidot.com/alwaysringonimportantcontact) to create a Tasker profile that plays an audio file when a call comes in

Fatal flaw: There's an Android OS [bug](https://android.stackexchange.com/questions/139524/turn-ringer-to-loud-from-vibrate-when-a-particular-contact-calls#comment178601_139525) that causes the ringtone to continue looping forever?! The provided workaround doesn't work on my Pixel 2.
