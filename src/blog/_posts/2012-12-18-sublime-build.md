---
description: Custom build systems for LaTeX and Sass.
tags: code
title: Sublime Text Build Systems
---

Pretty much what it says on the tin. Open [Sublime](http://www.sublimetext.com) and go to Tools > Build Systems > New Build System, paste in the code, and save under whatever name you want. You'll then be able to save and compile these special filetypes just by hitting F7. I'm using Linux, so you may need to replace a few of the Bash commands with their Batch equivalents if you're on Windows.

## LaTeX

This compiles LaTeX source, creates/updates a PDF with the same filename, and deletes the intermediate files. Requires LaTeX and pdflatex to be installed already.

```json
{
  "cmd": [
    "pdflatex --file-line-error-style '$file_name'; rm -f '$file_base_name.log' '$file_base_name.aux' '$file_base_name.out'"
  ],
  "selector": "text.tex.latex",
  "shell": true
}
```

## Sass

Requires Sass and the [Sass plugin](https://github.com/nathos/sass-textmate-bundle) for Sublime.

```json
{
  "cmd": ["sass --style compressed '$file_name' '$file_base_name.css'"],
  "selector": "source.sass",
  "shell": true
}
```

## LilyPond

Requires LilyPond and the [LilyPond plugin](https://github.com/yrammos/SubLilyPond) for Sublime.

```json
{
  "cmd": ["lilypond '$file_base_name.ly'"],
  "selector": "source.lilypond",
  "shell": true
}
```
