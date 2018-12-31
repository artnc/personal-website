.DEFAULT_GOAL := serve
MAKEFLAGS += --silent
SHELL = /usr/bin/env bash

# Build production files
.PHONY: build
build:
	# Crush all uncrushed PNGs
	./dockerize python scripts/pngcrush.py

	# Build Jekyll
	./dockerize bash -c 'cd src && jekyll build --config "_config.yml,_config.prod.yml"'

	# Compress HTML and inline CSS/JS
	./dockerize java -jar scripts/htmlcompressor-1.5.3.jar \
		--closure-opt-level whitespace \
		--compress-css \
		--compress-js \
		--js-compressor closure \
		--mask \*.html \
		--output ./build/ \
		--recursive \
		--remove-intertag-spaces \
		--remove-quotes \
		--type html \
		./build/

	# Compress XML
	./dockerize java -jar scripts/htmlcompressor-1.5.3.jar \
		--mask \*.xml \
		--output ./build/ \
		--recursive \
		--remove-intertag-spaces \
		--type xml \
		./build/

# Watch Jekyll source directory for changes and serve at localhost:8005
.PHONY: serve
serve:
	./dockerize bash -c 'cd src && jekyll serve --livereload'

# Submit sitemap to Google and Bing (lol?)
.PHONY: sitemap
sitemap:
	./dockerize curl -i -X PUT \
		-H "Authorization: Bearer ${token}" \
		"https://content.googleapis.com/webmasters/v3/sites/https%3A%2F%2Fchaidarun.com%2F/sitemaps/https%3A%2F%2Fchaidarun.com%2Fsitemap.xml"
	./dockerize curl -Ii \
		'http://www.bing.com/ping?sitemap=https%3A%2F%2Fchaidarun.com%2Fsitemap.xml'

# Upload to DigitalOcean via rsync
.PHONY: sync
sync: build
	./dockerize rsync -azP build/ art@${host}:/home/art/site
