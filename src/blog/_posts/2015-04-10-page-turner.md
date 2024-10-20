---
layout: post
ogimage: /img/page-turner.jpg
tags: ["linux", "music"]
title: Turning Pages with Face Recognition
---

Nearly all of my sheet music is in PDF. I'm usually too ~~lazy~~&nbsp;~~cheap~~ environmentally friendly to print it out, and sadly there are only so many notes that can fit on a screen. My playing has typically been littered with impromptu rest measures caused by my reaching for the mouse to scroll down.

Last night I hacked together a little program that allows you to send PageUp and PageDown keypresses by tilting your head. It only supports Linux for now.

<div class="text-centered">
  <img alt="OpenCV page turner" src="/img/page-turner.jpg">
</div>

## Installation

Make sure you have the required libraries.

```shell
# Ubuntu:
sudo apt-get install libopencv-dev python-opencv

# Fedora:
sudo yum install opencv-devel opencv-python
```

Get the [code](https://github.com/artnc/opencv-page-turner).

```shell
git clone https://github.com/artnc/opencv-page-turner.git
cd opencv-page-turner
```

Run it!

```shell
python pageturner.py
```

## Usage

Tilting your head to the left sends a PageUp keypress to the active window; tilting to the right sends PageDown. Run the program, open your sheet music in a PDF reader, and start playing.

Note that this page turner's reliance on subtle head movements discourages physically expressive styles of play&mdash;sorry, Lang Lang.
