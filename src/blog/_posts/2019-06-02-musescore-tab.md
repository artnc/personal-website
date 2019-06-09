---
h1: Writing Guitar Tabs in MuseScore
layout: post
pagetitle: Writing Guitar Tabs in MuseScore
tags: ["linux"]
---
After brief forays into LilyPond and TuxGuitar (and a failed attempt at running Guitar Pro in Wine), I've settled on [MuseScore](https://musescore.org/en) for my guitar tabbing needs. Here are some notes on how I produce tab files like <a href="/files/tab/Journey - Don't Stop Believin'.pdf">this one</a>:

<object style="height:500px;width:100%;" type="application/pdf" data="/files/tab/Journey - Don't Stop Believin'.pdf?#navpanes=0&scrollbar=0&statusbar=0&toolbar=0&view=FitH">
  <a href="/files/tab/Journey - Don't Stop Believin'.pdf">Journey - Don't Stop Believin'.pdf</a>
</object>

For more advanced topics, check out MuseScore's [Tablature](https://musescore.org/en/handbook/tablature) handbook.

## Creating a new file

1. In the new score wizard, enter Title and Composer
1. Select the "Choose new instruments" template
1. Add "Acoustic Guitar" or "Classical Guitar"
1. Select the newly added staff, click "Add Linked Staff", and change that second staff's type to "Tab. 6-str. common"

## Customizing the music font

In "Format" > "Style" > "Score", set the music symbols font to Bravura. The default choice of LilyPond's Emmentaler works fine, but I prefer heavier fonts for legibility.

## Styling the tab staff

I find MuseScore's default tab style pretty noisy and hard to read. Keeping note values and ties confined to the standard staff results in a cleaner tab staff.

1. Right-click the tab staff and select "Staff/Part Properties"
1. Click "Advanced Style Properties"
1. Change the font to Musescore Tab Sans
1. Decrease the font size to 8pt
1. Uncheck "Show back-tied fret marks"
1. In the "Note Values" tab, select "Shown as: None"

## Performance techniques

Since MuseScore is intended as a general-purpose score editor for all instruments, expressing guitar-specific performance techniques sometimes takes a little creativity.

### Hammer-ons and pull-offs

These are usually written as slurs. Since slurs are visually similar to ties, you'll want to hide all ties in the tab staff first.

1. Complete all aspects of your tab except for hammer-ons/pull-offs
1. Right-click a tie (if any exist) in your tab staff and choose "Select" > "All Similar Elements in Same Staff"
1. Hit `v` to toggle all selected ties' visibility to invisible
1. On the starting note of each hammer-on/pull-off, hit `s` to create a slur to the next note

### Slides

I use a straight glissando for slower slides and an appoggiatura for faster slides. Both marks are available in the "Palettes" pane. Dragging a glissando to the tab staff (as opposed to the standard staff) will produce a clean line without the unnecessary "gliss." text.

### Slaps

1. Enter each slap as an E2 note, i.e. fret 0 on the low E string
1. Hold down `Ctrl`, select those 0's, and hit `Shift+X` to display them as X's
1. In the standard staff, select the corresponding note heads and set "Head group: Cross" in the Inspector pane

Note that these X notes do make sound as E2 during audio playback, although they're at least low enough to not be overly distracting. MuseScore doesn't really provide a perfect solution to this problem, pointing to the fact that it's primarily a score editor and not a score player.

## Generating PDFs from the command line

```bash
mscore input.mscz -o output.pdf
```

To be extra fancy, you can set up `inotifywait` to run this command on save.
