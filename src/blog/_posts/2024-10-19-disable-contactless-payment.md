---
layout: post
ogimage: /img/contactless-chip.jpg
title: How to Disable Contactless Payment on a Credit Card
---

An exercise in hyperoptimizing my daily life.

![](/img/contactless-chip.jpg)

## What's wrong with tap to pay?

Nothing, in general. It's convenient and secure. But here's my situation:

- I want to pay for most things by tapping my phone, not my credit card. [Apple Pay](https://en.wikipedia.org/wiki/Apple_Pay) / [Google Pay](<https://en.wikipedia.org/wiki/Google_Pay_(payment_method)>) removes the need to carry all my physical credit cards everywhere.
- I want to carry exactly one physical credit card as a backup for vendors whom I can't easily pay by tapping my phone, e.g. most sit-down restaurants in the US.
- I want to minimize my everyday carry by storing that backup card inside my phone case's sleeve. I haven't bothered using a standalone wallet in years.

The problem with this setup is [card clash](https://tfl.gov.uk/fares/how-to-pay-and-where-to-buy-tickets-and-oyster/pay-as-you-go/card-clash). If I hold my phone up to a scanner, how does the scanner know whether to charge my phone's Google Pay vs. the physical credit card?

Another major annoyance is that Android beeps whenever it detects an [NFC](https://en.wikipedia.org/wiki/Near-field_communication) device in close proximity, and there's no way to turn off that "feature" without turning off NFC itself. Housing my NFC-enabled credit card inside my phone case causes Android to beep every single time I unlock my phone.

## The solution

Shining my phone's flashlight through my plastic credit card revealed a long metal wire, the NFC antenna, running along the card's perimeter. Like Alexander cutting the Gordian knot, I pulled out some scissors and made a tasteful half-centimeter snip just below the magnetic stripe. Problem solved!

Now I can keep my backup credit card inside my phone case without having it interfere with Google Pay or cause undue beeping. Although the physical card's contactless payment feature is toast, I've [verified](/img/contactless-receipt.jpg) that its chip and magnetic stripe both still work.

I don't feel too bad about severing the antenna wire since I've already added the backup card itself to my digital Google Pay wallet, meaning that I can still use my phone to make contactless payments on that card's behalf if I really need to for whatever reason.

![](/img/contactless-gordian-knot.jpg)

## Appendix: various non-solutions

Honestly, the main purpose of this whole post is to remind myself why I resorted to vasectomizing my own credit card. Here's everything else I tried:

- **Removing the card from my phone case every time I pay for something.** This obvious solution to the card clash problem wastes a few seconds, puts extra wear and tear on both the card and my phone case, introduces some risk of dropping the card and/or my phone, doesn't get rid of Android's unlock beeps, and is just plain annoying to do multiple times a day.

- **Requesting a contactless-less card.** I called my credit cards' issuers, carefully explained my use case, and asked whether they could send me a replacement card that totally lacks the contactless payment feature (as opposed to disabling it remotely on their end). None of the issuers said they could do so.

- **Erasing data.** Apps like [NFC Tools](https://play.google.com/store/apps/details?id=com.wakdev.wdnfc) allow you to modify data on certain NFC devices, but unsurprisingly my credit cards are read-only.

- **Lots of aluminum foil.** I hoped that an insulating layer of aluminum foil sandwiched between my phone and the card would allow me to choose a payment method by simply holding my phone in different orientations: scanning the back side of my phone would use the physical card's contactless payment feature, while scanning the front side of my phone would use Google Pay. Unfortunately, my phone's NFC reader is located in the middle of its back side and doesn't work from the front.<br><br>![](/img/contactless-foil.jpg)

- **Less aluminum foil.** Since Google Pay works only on my phone's back side, covering the entire back with foil isn't an option. But what if I were to tape some foil directly onto the credit card instead, using only enough foil to block the card's contactless receiver? Maybe my phone could still get enough signal passing through the unshielded portions of the card for Google Pay to work, kind of like how QR codes still work even if you stick a random logo in the middle of them. Alas, this approach fails because the credit card's antenna takes up so much space, practically covering the entire card. Foil foiled again.

- **Dishonorable mention: microwaving the credit card.** I didn't actually try this method. Someone on Reddit suggested it as a way to disable the chip, which is overkill for my use case anyway.
