.PHONY: all
all: serve

# Build production files
.PHONY: build
build: _install-ruby-deps
	# Crush all uncrushed PNGs
	python scripts/pngcrush.py

	# Build Jekyll
	cd src && jekyll build --config "_config.yml,_config.prod.yml"

	# Compress HTML and inline CSS/JS
	echo "Running htmlcompressor..."
	java -jar scripts/htmlcompressor-1.5.3.jar \
	  --closure-opt-level whitespace \
	  --compress-css \
	  --compress-js \
	  --js-compressor closure \
	  --mask \*.html \
	  --output ./build/ ./build/ \
	  --recursive \
	  --remove-intertag-spaces \
	  --remove-quotes \
	  --type html

	# Compress XML
	java -jar scripts/htmlcompressor-1.5.3.jar \
	  --mask \*.xml \
	  --output ./build/ ./build/ \
	  --recursive \
	  --remove-intertag-spaces \
	  --type xml

# Watch Jekyll source directory for changes and serve at localhost:8005
.PHONY: serve
serve: _install-ruby-deps
	cd src && jekyll serve --livereload --port 8005

# Submit sitemap to Google and Bing (lol?)
.PHONY: sitemap
sitemap:
	curl -i -X PUT \
	  -H "Authorization: Bearer ${token}" \
	  "https://content.googleapis.com/webmasters/v3/sites/https%3A%2F%2Fchaidarun.com%2F/sitemaps/https%3A%2F%2Fchaidarun.com%2Fsitemap.xml"
	curl -Ii "http://www.bing.com/ping?sitemap=https%3A%2F%2Fchaidarun.com%2Fsitemap.xml"

# Upload to DigitalOcean via rsync
.PHONY: sync
sync: build
	rsync -azP build/ art@${host}:/home/art/site

.PHONY: _install-ruby-deps
_install-ruby-deps:
	bundle install
