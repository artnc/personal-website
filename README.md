chaidarun.com
=============

### custom page variables

- description         = content for meta description
- headcss             = extra css for head
- headjs              = extra js for head
- h1                  = what should go inside h1 tags
- pagetitle           = what should go inside title tags
- secret              = true iff page should be published but not sitemapped

### includes

- ga                  = google analytics js
- piwik               = piwik js

### layouts

- blank               = nothing but {{ content }}
- default             = page without timestamp/tags
- minimal             = complete head, empty body
- post                = page with timestamp/tags

### sass partials

- allpages            = applies to all pages
- lightbox            = for lightbox.js
- normalize           = normalize.css reset
- pagespecific        = filtered by body class
- syntax              = for pygments
- tipsy               = for tipsy plugin
- variables           = sass variables, mixins
- webfonts            = fonts

### workflow tools

- _documentation.txt  = summary of my changes to default jekyll install
- _minify/            = htmlcompressor, closure binaries
- _minify.sh          = minify all html and css inside _site
- _notes.md           = scratchpad for commit changes, todos, etc
- _png.sh             = pngcrush all uncrushed pngs
- _pngcrushed.txt     = list of all crushed pngs

### publishing

1. _png.sh
1. sass build
1. jekyll build
1. _minify.sh
1. ftp
1. git
