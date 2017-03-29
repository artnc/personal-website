---
h1: Simple Intro to Node.js, npm, and webpack
layout: post
pagetitle: Simple Intro to Node.js, npm, and webpack
tags: ["web"]
comments: true
---
> This was originally written for fellow [Duolingo](https://www.duolingo.com/) employees and therefore assumes that the reader is familiar with Python.

## What's Node.js? Why are we using it?

Node.js bills itself as "server-side JavaScript" and is the most widely used JS equivalent of Python's `python` terminal command. Running `node` without arguments will start an interactive JS shell, and running `node foobar.js` will execute the contents of foobar.js, printing any output to stdout.

Node.js is *not* a webserver, a web app framework, or the name of a file.

What's the point of having a JS interpreter outside of your browser? Many web development tools (e.g. Less) are written in JS. Why weren't those tools written in C++, Python, etc.? Approximately 100% of the open-source web community knows JS; no other language comes close.

## What's npm? Why are we using it?

npm ("node package manager") is the most widely used JS equivalent of Python's pip. Main differences:

- npm records installed packages in a file called package.json, while pip traditionally stores them in a file called requirements.txt.

    `npm install` will install all packages listed in the current directory's package.json. The pip equivalent is `pip install -r requirements.txt`.

- npm installs packages into the current directory's node\_modules/ subdirectory, creating it if necessary. pip installs packages at a location within the current Python installation itself.

    Python projects typically use a virtualenv so that project-specific libraries don't clutter your system's main Python installation. Since npm installs to the current directory's node\_modules/ by default, any directory with a node\_modules/ subdirectory is effectively its own contained environment.

    Very rarely, you want a package to be globally available. With pip you run `pip install foobar` outside of any virtualenv; with npm you run `npm install -g foobar` from any directory.

## What's webpack? Why are we using it?

Webpack is a build system like Make or Gradle. At a minimum, we need it for combining hundreds of JS source files into a few that we send to the browser. It does so by implementing a module import system---a fairly universal language feature that vanilla JS doesn't yet provide.

The other main feature of webpack that we currently use is `webpack-dev-server`, a companion tool that can automatically build our JS and serve it from localhost:9091. This separation from the Paste server drastically reduces the time wasted on local server reloads because:

- Paste no longer reloads our Python backend whenever you make a JS change
- Paste no longer rebuilds our entire JS codebase whenever you make a Python change
- webpack-dev-server rebuilds only the edited module, not our entire JS codebase
