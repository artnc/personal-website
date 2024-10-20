---
layout: post
tags: ["web"]
title: Tiny Tiny RSS on Heroku
---

> Update 2021-12-24: Looks like someone else has [further iterated](https://github.com/serl/ttrss-heroku) on the process outlined in this post? I haven't had a chance to try&mdash;nowadays I use Inoreader.

This takes 5-10 minutes from start to finish :) The only prerequisite tools are [git](https://git-scm.com/) and the [Heroku CLI](https://toolbelt.heroku.com/).

1. Download a local copy of TTRSS.

   ```shell
   git clone https://github.com/gothfox/Tiny-Tiny-RSS.git
   cd Tiny-Tiny-RSS
   ```

1. Open `config.php-dist`, change the value of `SESSION_CHECK_ADDRESS` from 1 to 0, and save.

1. Set up a new Heroku project. Replace `$APP_NAME` below with a custom project name, e.g. `john-doe-ttrss` to have your TTRSS instance live at `https://john-doe-ttrss.herokuapp.com`.

   ```shell
   heroku login
   heroku create $APP_NAME
   heroku addons:create heroku-postgresql:hobby-dev
   ```

1. Add a few special files needed by Heroku.

   ```shell
   cat << EOM > Procfile
   web: ~/web-boot.sh
   EOM
   cat << EOM > composer.json
   {
     "require": {
       "ext-mbstring": "*"
     }
   }
   EOM
   cat << EOM > web-boot.sh
   sed -i 's/^ServerLimit 1/ServerLimit 8/' ~/.heroku/php/etc/apache2/httpd.conf
   sed -i 's/^MaxClients 1/MaxClients 8/' ~/.heroku/php/etc/apache2/httpd.conf
   vendor/bin/heroku-php-apache2
   EOM
   chmod +x web-boot.sh
   git add -A
   git commit -m "Add Heroku files"
   ```

1. Push your local TTRSS repo to Heroku.

   ```shell
   git push heroku master
   ```

1. Go to your app's database in the [Heroku Postgres dashboard](https://postgres.heroku.com/databases) and copy its connection settings into your new TTRSS instance, which can be found at the URL described in step 3.

1. Complete the installation wizard by clicking _Test configuration_, _Initialize database_, and _Save configuration_.

1. Log in to your TTRSS instance with the default username `admin` and password `password`.

## Acknowledgements

This guide is based on Reuben Castelino's impressively detailed [blog post](http://projectdelphai.github.io/blog/2013/03/15/replacing-google-reader-with-tt-rss-on-heroku/) on the subject. I attempt to improve on his method by:

- Favoring the normal TTRSS database initialization process over manual initialization

- Leveraging Heroku's `composer.json` support instead of relying on a prebuilt copy of `mbstring.so`

- Preventing the `Session failed to validate (incorrect IP)` login error

- Being more concise (he did thoughtfully condense his post into a shell script for us TLDR folks, but unfortunately it no longer works)

## Extra Credit

I highly recommend the [Feedly theme](https://github.com/levito/tt-rss-feedly-theme) for TTRSS. You can easily convert it into a <a href="/img/ttrss-dark.jpg" class="nounderline" title="The dark theme rises">dark theme</a> by going to _Preferences > Customize stylesheet_ and pasting in the following:

```css
body {
  -webkit-filter: invert(100%);
  filter: invert(100%);
}

img {
  -webkit-filter: invert(100%);
  filter: invert(100%);
}

.scoreWrap {
  display: none !important;
}
```
