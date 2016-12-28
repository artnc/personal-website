---
h1: Turning Pages with Face Recognition
layout: post
pagetitle: Turning Pages with Face Recognition
tags: ["linux", "music"]
comments: true
---
Nearly all of my sheet music is in PDF. I'm usually too <span style="text-decoration:line-through">lazy</span>&nbsp;<span style="text-decoration:line-through">cheap</span> environmentally friendly to print it out, and sadly there are only so many notes that can fit on a screen. My playing has typically been littered with impromptu rest measures that occur when I reach for the mouse to scroll down.

Last night I hacked together a little program that allows you to send PageUp and PageDown keypresses by tilting your head. For now, it runs only on Linux and detects only human faces.

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

Note that this page turner's reliance on subtle head movements discourages a physically expressive style of play&mdash;sorry, Lang Lang.
