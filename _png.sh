# Crush all PNGs
for png in `find . -name "*.png"`
do
  if grep -Fxq "$png" ./_pngcrushed.txt; then
    echo "already crushed $png"
  else
    echo "crushing        $png"
    pngcrush "$png" _tmp.png &>/dev/null
    mv -f _tmp.png "$png"
    echo "$png" >> ./_pngcrushed.txt
  fi
done
