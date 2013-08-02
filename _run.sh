# Crush all uncrushed PNGs
for png in `find files css img -name "*.png"`
do
  if ! grep -Fxq "$png" ./_pngcrushed.txt; then
    echo "crushing $png"
    pngcrush "$png" _tmp.png &>/dev/null
    mv -f _tmp.png "$png"
    echo "$png" >> ./_pngcrushed.txt
  fi
done

# Build SASS
sass --style compressed ./css/main.scss ./css/main.css

# Build Jekyll
jekyll build

# Delete certain files from _site
rm -f ./_site/README.md
rm -f ./_site/css/main.scss

# Compress HTML and inline CSS/JS
echo "Running htmlcompressor..."
java -jar _minify/htmlcompressor-1.5.3.jar --recursive --remove-intertag-spaces --remove-quotes --js-compressor closure --compress-js --compress-css --closure-opt-level simple --mask \*.html -o ./_site/ ./_site/

# Compress XML
java -jar _minify/htmlcompressor-1.5.3.jar --recursive --remove-intertag-spaces --type xml --mask \*.xml -o ./_site/ ./_site/
