# Build main.scss
sass --style compressed ./css/main.scss ./css/main.css

# Build Jekyll
jekyll build

# Delete certain files from _site
rm -f ./_site/README.md
rm -f ./_site/css/main.scss

# Compress HTML
echo "Running htmlcompressor..."
java -jar _minify/htmlcompressor-1.5.3.jar --recursive --remove-quotes --remove-intertag-spaces --mask \*.html -o ./_site/ ./_site/
