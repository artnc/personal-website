#!/usr/bin/env bash

set -eu

host='https%3A%2F%2Fchaidarun.com'
w3='https://validator.w3.org'
rate_limit_message='Just a moment...'
errors=()

# Validate prominent pages' HTML
html_validator="${w3}/nu/?out=json&doc=${host}"
for slug in '' blog duolingo integral neuron projects; do
  sleep 2
  response="$(curl -s "${html_validator}%2F${slug}")"
  filter='
    .messages
    | map(select(
      .message
        | test("element must have an “alt” attribute|“img” is missing required attribute “src”")
        | not
    ))
    | map("\n  " + .message + "\n    " + .extract)
    | join("")'
  if printf %s "${response}" | grep -qF "${rate_limit_message}"; then
    echo "Hit rate limit, unable to validate /${slug}"
  elif printf %s "${response}" | jq -r "${filter}" &> /dev/null; then
    messages="$(printf %s "${response}" | jq -r "${filter}")"
    if [[ -n ${messages} ]]; then
      errors+=("Errors for /${slug}:${messages}")
    else
      echo "Validated /${slug}"
    fi
  else
    errors+=("Failed to parse response for /${slug}: ${response}")
  fi
done

# Validate CSS
css_path="$(curl -s 'https://chaidarun.com/404' | grep -oE '"/css/\w+\.css')"
if [[ -n ${css_path} ]]; then
  css_file="$(echo "${css_path}" | cut -d/ -f3)"
  css_validator="https://jigsaw.w3.org/css-validator/validator?uri=${host}%2Fcss%2F${css_file}&profile=css3svg&usermedium=all&warning=1&vextwarning=&lang=en"
  if curl -s "${css_validator}" | grep -q Congrat; then
    echo 'Validated CSS'
  else
    errors+=("Invalid CSS: ${css_validator}")
  fi
else
  errors+=("CSS file not found")
fi

# Validate RSS
rss_validator="${w3}/feed/check.cgi?url=${host}%2Ffeed.xml"
response="$(curl -s "${rss_validator}")"
if printf %s "${response}" | grep -qF "${rate_limit_message}"; then
  echo 'Hit rate limit, unable to validate RSS'
elif printf %s "${response}" | grep -q Congrat; then
  echo 'Valid RSS'
else
  errors+=("Invalid RSS: ${rss_validator}")
fi

# Print errors
if [[ ${#errors[@]} -gt 0 ]]; then
  for error in "${errors[@]}"; do
    echo "${error}"
  done
  exit 1
else
  echo 'No validation errors found!'
fi
