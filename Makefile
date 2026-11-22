.DEFAULT_GOAL := serve
MAKEFLAGS += --silent
SHELL = /usr/bin/env bash

_DOCKER_IMAGE = -v "$${PWD}:/code" \
	"$$(docker build -q -t artnc/personal-website .)"
_DOCKER_OPTIONS = --rm -it $(_DOCKER_IMAGE)

# Build production files
.PHONY: build
build:
	docker run $(_DOCKER_OPTIONS) make _build
.PHONY: _build
_build:
	echo 'Deleting build folder...'
	rm -rf build
	echo 'Crushing all uncrushed PNGs...'
	python3 scripts/pngcrush.py
	echo 'Building Jekyll...'
	cd src && jekyll build --config '_config.yml,_config.prod.yml' 2> /dev/null
	echo 'Compressing HTML and inline CSS/JS...'
	html-minifier-terser \
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
	md5="$$(md5sum build/css/main.css | cut -c-8)" \
		&& echo "Hash: $${md5}" \
		&& mv build/css/main.css "build/css/$${md5}.css" \
		&& find build -type f -name '*.html' \
		| xargs sed -i "s@css/main\.css@css/$${md5}\.css@g"

# Run Isso. ISSO_ADMIN_PASSWORD can be set to anything - just remember it for
# use at /admin
.PHONY: comments
comments:
	[[ -n "$${ISSO_ADMIN_PASSWORD}" ]]
	mkdir -p ~/.config/isso
	sed "s/__ISSO_ADMIN_PASSWORD__/$${ISSO_ADMIN_PASSWORD}/g" isso.cfg > ~/.config/isso/isso.cfg
	docker rm -f isso &> /dev/null || true
	# https://isso-comments.de/docs/reference/installation/#using-docker. The
	# container restarts on boot until you run `docker stop isso`. The command
	# overrides the image's default `-w 4` to save about 90 MB of RAM
	docker run -d --name isso --restart unless-stopped \
		-p 127.0.0.1:8080:8080 \
		-v "$${HOME}/.config/isso:/config" \
		-v "$${PWD}:/db" \
		ghcr.io/isso-comments/isso:0.13.0 \
		/isso/bin/gunicorn -b 0.0.0.0:8080 -w 1 --preload isso.run --worker-tmp-dir /dev/shm > /dev/null

# Upload to DigitalOcean via rsync
# https://stackoverflow.com/a/11829094
.PHONY: deploy
deploy: build
	docker run $(_DOCKER_OPTIONS) rsync -azP \
		--delete build/ \
		-e "ssh -o StrictHostKeyChecking=no" \
		--quiet \
		root@${host}:/var/www/html

# Watch Jekyll source directory for changes and serve at localhost:4000. The
# container restarts on boot until you run `docker stop personal-website`
.PHONY: serve
serve:
	echo 'Starting Jekyll in background...'
	docker rm -f personal-website &> /dev/null || true
	docker run -d -t --name personal-website --restart unless-stopped \
		-p 4000:4000 -p 35729:35729 $(_DOCKER_IMAGE) \
		sh -c 'cd src && jekyll serve --livereload' > /dev/null
	echo 'Run `docker logs -f personal-website` to view logs'

# Validate HTML and RSS
.PHONY: validate
validate:
	bash scripts/validate.sh
