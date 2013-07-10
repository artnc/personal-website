chaidarun.com
=============

custom page variables:
- description         = content for meta description
- h1                  = what should go inside h1 tags
- pagetitle           = what should go inside title tags
- secret              = true iff page should be published but not sitemapped

layouts:
- blank               = nothing but {{ content }}
- default             = page without timestamp/tags
- minimal             = complete <head>, empty <body>
- post                = page with timestamp/tags

workflow tools:
- _documentation.txt  = summary of my changes to jekyll
- _minify/            = compressor binaries
- _minify.sh          = minify all html and css inside _site
- _png.sh             = pngcrush all uncrushed pngs
- _pngcrushed.txt     = list of all crushed pngs
