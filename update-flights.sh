#!/usr/bin/env bash
# Refresh the data used by /add-flight-to-calendar

# Delete stale data
pushd src/files &> /dev/null
rm -f flights-*.json

# https://openflights.org/data.php
function get_openflights_data() {
  filename="${1}"
  fields="${2}"
  python3 - << EOF
import csv, io, json, urllib.request
r = urllib.request.urlopen(urllib.request.Request(
  "https://raw.githubusercontent.com/jpatokal/openflights/master/data/${filename}.dat"
))
f = io.StringIO(r.read().decode().replace("\\\\N", "").replace("\\\\", ""))
print(json.dumps(list(csv.DictReader(f, fieldnames="${fields}".split()))))
EOF
}

# Pull airline data
OUTPUT_FILE="flights-$(date '+%Y-%m-%d').json"
printf '{"airlines":' > "${OUTPUT_FILE}"
get_openflights_data airlines \
  'id name alias iata icao callsign country active' \
  | jq -Scj 'values
    | map(
      select(
        .active == "Y"
        and .icao != ""
        # Data is pretty messy, containing junk like "??" and "::". We also
        # ignore small airlines with fully numerical IATA codes (e.g. 20)
        # because they significantly complicate email parsing
        and (.iata | test("^[A-Z][A-Z0-9]$"))
      )
      | {iata, name}
    )
    | sort_by(.iata)' \
    >> "${OUTPUT_FILE}"

# Pull airport data
printf ',"airports":' >> "${OUTPUT_FILE}"
get_openflights_data airports \
  'id name city country iata icao lat lon altitude offset dst tz type source' \
  | jq -Scj 'values
    | map(select(.iata != "") | {city, iata, name, tz})
    | sort_by(.iata)' \
    >> "${OUTPUT_FILE}"
printf '}
' >> "${OUTPUT_FILE}"

# Update code
popd &> /dev/null
sed -i "s/flights-.*?json/${OUTPUT_FILE}/g" \
  src/projects/_posts/2025-06-01-add-flight-to-calendar.html
