.PHONY: all
all: serve

# Watch Sass for changes
.PHONY: css
css:
	wr -c 0 "sass --style compressed --sourcemap=none src/css/_main.scss src/css/main.css" src/css/*.scss

# Build production files
.PHONY: build
build:
	# Crush all uncrushed PNGs
	python scripts/pngcrush.py

	# Build Sass
	sass --style compressed --sourcemap=none src/css/_main.scss src/css/main.css

	# Build Jekyll
	jekyll build

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

# Serve website at localhost:8005
.PHONY: serve
serve:
	cd build && ../scripts/serve.py

# Upload to DigitalOcean via rsync
.PHONY: sync
sync:
	rsync -azP build/ art@${host}:/home/art/site

# Watch Jekyll source directory for changes
.PHONY: watch
watch:
	jekyll build --watch