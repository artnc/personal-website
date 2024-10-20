---
layout: post
tags: ["linux"]
title: Bash Style Guide for Mac and Linux
---

Yesterday I had the deranged pleasure of writing 1000+ lines of cross-platform Bash, which got me thinking that I could probably save myself some unnecessary googling and/or decision-making in future projects by documenting my stylistic choices and the reasons behind them. I don't expect that these guidelines will ever be completely finished, but for now:

- **Follow [Google's style guide](https://google.github.io/styleguide/shell.xml) and use [ShellCheck](https://github.com/koalaman/shellcheck)**. These resources have hundreds of good opinions that will save me a ton of typing here.

- **Stick to Bash 3.** Apple preinstalls a decrepit version of Bash from 2007 because [they don't like GPL v3](https://www.reddit.com/r/osx/comments/51v1jg/what_is_the_reason_for_osx_to_use_bash_3257_and/). I use Linux but often write scripts for Mac users, so that's a portability issue I can't ignore. Although Bash 4 globs and associative arrays must be avoided, older [bashisms](https://mywiki.wooledge.org/Bashism) like `[[` are totally fine by me.

- **If you must drop into another language, use version-independent Python.** Some simple tasks like percent-encoding and JSON parsing require a more fully featured language than Bash. Macs and all major Linux distros ship with Python included (and Perl too, although Python is rather more hip these days).

  [Heredoc](https://en.wikipedia.org/wiki/Here_document) syntax lets you declare foreign code snippets inline inside a Bash script. Your code should support both Python 2 and 3 since you'll likely have end users on both versions. PyPI packages are out of the question&mdash;at that point you might as well give up on Bash and switch to either Docker or a statically compiled language.

  ```bash
  readonly response="$(curl -s 'https://example.com')"
  python - << EOF
  # -*- coding: utf-8 -*-
  import json
  for repo, result in sorted(json.loads(r'''${response}''')['Results'].items()):
    for f in result['Matches']:
      for l in f['Matches']:
        print('%s/%s:%s:%s' % (repo, f['Filename'], l['LineNumber'], l['Line']))
  EOF
  printf 'Hello from Bash land again\n'
  ```

  Note that in this example, the Bash variable `response` is interpolated into a raw, triple-quoted Python string as `r'''${response}'''` in order to avoid possible issues caused by unescaped characters.

- **Use shebang `#!/usr/bin/env bash`.** The most common Bash [shebangs](<https://en.wikipedia.org/wiki/Shebang_(Unix)>) are `/bin/bash` and (abusedly) `/bin/sh`, but I like to use `env` for consistency with other languages' standard shebangs.

- **Always declare `set -eu`.** There's never a good reason to swallow errors and continue script execution as if nothing happened. There's _sometimes_ a good reason to allow undeclared variables, but I find it safer to use default values in those cases.

- **Always use `printf` instead of `echo`.** This one's a bit controversial. POSIX and Bash's maintainer both [recommend](https://askubuntu.com/a/537987) `printf` over `echo` for portability and robustness. Dogma aside, I prefer `printf` because I often don't want `echo`'s trailing newline, e.g. when piping a string variable into `grep -qE '^foobar$'`.

- **Always use `while read -r ... done <` to loop through lines.** The `| while` form of the loop runs its contents in a subshell, which is rarely desired since any variable assignments that happen in there will be lost.

  ```bash
  # Bad
  echo "${var}" | while read line; do
    printf '%s\n' "${line}"
  done

  # Good
  while read -r line; do
    printf '%s\n' "${line}"
  done <<< "${var}"

  # Good
  while read -r line; do
    printf '%s\n' "${line}"
  done < file.txt

  # Good
  while read -r line; do
    printf '%s\n' "${line}"
  done < <(find . -type f)
  ```

- **Always use `[[` instead of `[`.** The former is a more powerful drop-in replacement for the latter, and it's simpler to always use `[[` rather than remember all of the subtle differences.

- **Always use `${HOME}` instead of `~`.** Only the former gets expanded inside double-quoted strings.

- **Prefer `shift` to `$2`.** Calling `shift` immediately after reading each command-line argument lets you always refer to them as `$1`, which removes the need for a reader of your code to mentally keep track of argument indices and reduces the chance of making mistakes when adding or removing arguments.

- **Never read the same value from `$1` twice.** If you're going to use a command-line argument multiple times, it's a good defensive practice to immediately store it into a named variable&mdash;especially when your program accepts multiple arguments.

- **Print logging messages to stderr in color.** This avoids tainting stdout and makes your logs easier to read and debug.

  ```bash
  # I'm calling these functions logX for consistency with Android's Log class

  logD() {
    if [[ -n "${DEBUG:-}" ]]; then
      printf '%s%s%s\n' "$(tput setaf 4)" "${1:-}" "$(tput sgr0)" >&2
    fi
  }

  logE() {
    printf '%s%s%s\n' "$(tput setaf 1)" "${1:-}" "$(tput sgr0)" >&2
  }

  logI() {
    printf '%s%s%s\n' "$(tput setaf 2)" "${1:-}" "$(tput sgr0)" >&2
  }

  logE 'I am a red error message'
  ```

- **Always use `grep -E` instead of `grep -P`.** The Mac version of `grep` doesn't support `-P`. [POSIX ERE](https://en.wikibooks.org/wiki/Regular_Expressions/POSIX-Extended_Regular_Expressions) is usually capable enough; the only [PCRE](https://en.wikipedia.org/wiki/Perl_Compatible_Regular_Expressions) feature I regularly miss is multiline matching.

- **Mark all variables `readonly` by default.** Code that doesn't reassign variables all over the place is easier to read. `readonly` also alerts you to unintended reassignments. Inside a function, use `local -r` instead of `readonly` to additionally limit a variable's scope to that function.

- **Always use `=` instead of `==` in tests.** `=` is equivalent, shorter, and more POSIXy.

- **Prefer `${var:-default}` to `${var-default}`.** It's simpler to have only one kind of empty value rather than treating unset and null differently. This behavior is also consistent with string interpolation, where unset variables and null variables both get interpolated as an empty string.

- **Indent a level between `pushd` and `popd`.** These two commands aren't actually control flow statements, but indenting them as such improves readability and reduces the chance of mismatches.

  ```bash
  # Bad
  pushd foo > /dev/null
  printf 'bar\n'
  printf 'baz\n'
  popd > /dev/null

  # Good
  pushd foo > /dev/null
    printf 'bar\n'
    printf 'baz\n'
  popd > /dev/null
  ```

- **Prefer `pushd`/`popd` to `cd`.** Combined with the previous tip, this makes code much easier to follow.

- **Always use `command -v` instead of `which`.** The former is POSIX compliant and more consistent between GNU (i.e. Linux) and Mac.

- **Trim whitespace from `wc` output.** The Mac version of `wc` prepends whitespace to its output. You can remove it with `awk`:

  ```bash
  find . -type f -name '*.pyc' | wc -l | awk '{print $1}'
  ```

- **Prefer single quotes to double quotes when interpolating into an `eval`.** This is pretty niche, but basically it's much [simpler](https://stackoverflow.com/questions/15783701/which-characters-need-to-be-escaped-when-using-bash#comment71498177_20053121) to programmatically escape characters inside single-quoted strings than inside double-quoted strings. Single-quoted strings only need to escape `'`, while double-quoted strings need to escape each of ``"$`\``.

  ```bash
  readonly json="$(< 'request_body.json')"
  readonly curl_command="curl 'https://example.com' -d '${json//\'/\'\\\'\'}'"
  printf '%s\n' "${curl_command}"
  eval "${curl_command}"
  ```

  Note that `printf %q` also does the job, but it's supposedly less reliable due to [bugginess](https://stackoverflow.com/questions/15783701/which-characters-need-to-be-escaped-when-using-bash#comment71234255_27817504) in old versions.
