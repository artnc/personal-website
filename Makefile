.DEFAULT_GOAL := serve
MAKEFLAGS += --silent
SHELL = /usr/bin/env bash

_DOCKER_RUN = docker run --rm -it \
	-p 4000:4000 -p 35729:35729 \
	-v "$${PWD}:/code" \
	"$$(docker build -q -t artnc/personal-website .)"

# Build production files
.PHONY: build
build:
	# Crush all uncrushed PNGs
	$(_DOCKER_RUN) python3 scripts/pngcrush.py

	# Build Jekyll
	$(_DOCKER_RUN) sh -c 'cd src && jekyll build --config "_config.yml,_config.prod.yml"'

	# Compress HTML and inline CSS/JS
	$(_DOCKER_RUN) java -jar scripts/htmlcompressor-1.5.3.jar \
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
	$(_DOCKER_RUN) java -jar scripts/htmlcompressor-1.5.3.jar \
		--mask \*.xml \
		--output ./build/ \
		--recursive \
		--remove-intertag-spaces \
		--type xml \
		./build/

# Watch Jekyll source directory for changes and serve at localhost:4000
.PHONY: serve
serve:
	$(_DOCKER_RUN) sh -c 'cd src && jekyll serve --livereload'

# Submit sitemap to Google and Bing (lol?)
.PHONY: sitemap
sitemap:
	$(_DOCKER_RUN) curl -i -X PUT \
		-H "Authorization: Bearer ${token}" \
		"https://content.googleapis.com/webmasters/v3/sites/https%3A%2F%2Fchaidarun.com%2F/sitemaps/https%3A%2F%2Fchaidarun.com%2Fsitemap.xml"
	$(_DOCKER_RUN) curl -Ii \
		'http://www.bing.com/ping?sitemap=https%3A%2F%2Fchaidarun.com%2Fsitemap.xml'

# Upload to DigitalOcean via rsync
# https://stackoverflow.com/a/11829094
.PHONY: sync
sync: build
	$(_DOCKER_RUN) rsync -azP \
		--delete build/ \
		-e "ssh -o StrictHostKeyChecking=no" \
		art@${host}:/home/art/site
