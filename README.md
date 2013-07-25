chaidarun.com
=============

### license

all rights reserved, except where otherwise noted

### documentation

custom page variables

- description         = content for meta description
- headcss             = extra css for head
- headjs              = extra js for head
- h1                  = what should go inside h1 tags
- pagetitle           = what should go inside title tags
- secret              = true iff page should be published but not sitemapped

includes

- ga                  = google analytics js
- piwik               = piwik js

layouts

- blank               = nothing but {{ content }}
- default             = page without timestamp/tags
- minimal             = complete head, empty body
- post                = page with timestamp/tags

sass partials

- allpages            = applies to all pages
- lightbox            = for lightbox.js
- normalize           = normalize.css reset
- pagespecific        = filtered by body class
- syntax              = for pygments
- tipsy               = for tipsy plugin
- variables           = sass variables, mixins
- webfonts            = fonts

workflow tools

- _minify/            = htmlcompressor/closure/yui binaries
- _notes.md           = scratchpad for commit changes, todos, etc
- _pngcrushed.txt     = list of all crushed pngs
- _run.sh             = build jekyll/sass, minify all _site html/css/js/png
- README.md           = summary of my changes to default jekyll install

### publishing

1. _run.sh
1. git
1. ftp
