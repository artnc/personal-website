.DEFAULT_GOAL := serve
MAKEFLAGS += --silent
SHELL = /usr/bin/env bash

_DOCKER_RUN = docker run --rm -it \
	-p 4000:4000 \
	-p 35729:35729 \
	-v "$${PWD}:/code" \
	"$$(docker build -q -t artnc/personal-website .)"

# Build production files
.PHONY: build
build:
	echo 'Deleting build folder...'
	$(_DOCKER_RUN) rm -rf build
	echo 'Crushing all uncrushed PNGs...'
	$(_DOCKER_RUN) python3 scripts/pngcrush.py
	echo 'Building Jekyll...'
	$(_DOCKER_RUN) sh -c 'cd src && jekyll build --config "_config.yml,_config.prod.yml"'
	echo 'Compressing HTML and inline CSS/JS...'
	$(_DOCKER_RUN) html-minifier-terser \
		--collapse-whitespace \
		--decode-entities \
		--file-ext html \
		--input-dir build \
		--minify-css \
		--minify-js \
		--output-dir build \
		--remove-comments \
		--remove-script-type-attributes \
		--remove-style-link-type-attributes \
		--sort-attributes \
		--sort-class-name \
		--use-short-doctype
	echo 'Adding hash to CSS file name...'
	$(_DOCKER_RUN) sh -c 'md5="$$(md5sum build/css/main.css | cut -c-8)" \
		&& echo "Hash: $${md5}" \
		&& mv build/css/main.css "build/css/$${md5}.css" \
		&& find build -type f -name '*.html' | xargs sed -i "s@css/main\.css@css/$${md5}\.css@g"'

# Run Isso. ISSO_ADMIN_PASSWORD can be set to anything - just remember it for use at /admin
.PHONY: comments
comments:
	[[ -n "$${ISSO_ADMIN_PASSWORD}" ]]
	mkdir -p /tmp/isso
	cp isso.cfg /tmp/isso/isso.cfg
	sed -i "s/__ISSO_ADMIN_PASSWORD__/$${ISSO_ADMIN_PASSWORD}/g" /tmp/isso/isso.cfg
	# https://isso-comments.de/docs/reference/installation/#using-docker
	docker run --rm \
		-p 127.0.0.1:8080:8080 \
		-v '/tmp/isso:/config' \
		-v "$${PWD}:/db" \
		ghcr.io/isso-comments/isso:0.13.0

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
		--quiet \
		root@${host}:/var/www/html
