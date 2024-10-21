# chaidarun.com

All rights reserved, except where otherwise noted.

## Code organization

- Custom page variables
  - description: content for meta description
  - headcss: extra css for head
  - headjs: extra js for head
  - omit_h1: true iff h1 should be omitted
  - jquery: whether jquery should be included
  - ogimage: og:image url
  - sitemap: false iff page should be published but not sitemapped
  - title: what should go inside h1 and title tags
- Includes
  - ga: google analytics js
- Layouts
  - default: page without timestamp/tags
  - minimal: complete head, empty body
  - post: page with timestamp/tags
- Sass partials
  - normalize: normalize.css reset
  - twilight: for pygments

## Workflow

- Developing: `make serve` to http://localhost:4000
- Publishing: `make deploy host=***` where `host` is droplet IP
- Serving comments: `ISSO_ADMIN_PASSWORD=*** make comments`
- Managing comments: `/isso/admin` on live site

## Server config

```shell
# Machine setup
# https://serverpilot.io/docs/how-to-enable-ssh-password-authentication/
# https://docs.digitalocean.com/products/monitoring/how-to/install-agent/#with-an-installation-script
# https://docs.digitalocean.com/products/droplets/how-to/connect-with-console/#install-and-configure-the-droplet-agent
# https://www.digitalocean.com/community/tutorials/how-to-create-a-new-sudo-enabled-user-on-ubuntu-22-04-quickstart
mkdir ~/code
sudo apt update
sudo apt upgrade
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04

# Environment setup
sudo apt install ripgrep zsh
cd ~/code
git clone https://github.com/artnc/dotfiles.git
chsh -s /usr/bin/zsh
cd ~/code/dotfiles
./install.sh
# Log out and then back in

# Nginx setup
sudo apt install nginx
sudo rm /var/www/html
cd ~/code
git clone https://github.com/artnc/personal-website.git
sudo ln -s /home/art/code/personal-website/nginx.conf /etc/nginx/sites-enabled/chaidarun.com.conf
sudo systemctl service restart nginx
# https://www.digitalocean.com/community/tutorials/how-to-host-a-website-using-cloudflare-and-nginx-on-ubuntu-20-04

# Isso setup
sudo apt install make
cd ~/code/personal-website
# On laptop: scp /path/to/local/backup.db ***:/home/art/code/personal-website/comments.db
```
