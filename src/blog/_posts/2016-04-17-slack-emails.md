---
h1: Forwarding Emails to Slack
layout: post
pagetitle: Forwarding Emails to Slack
tags: ["web"]
---
<img src="/img/slack-emails.jpg" style="max-width:100%">

You receive notification emails often and would rather send them to Slack instead of having them clutter your inbox. Here's a DIY solution that takes around 10 minutes to set up. Things you'll need:

- A Slack [API token](https://api.slack.com/docs/oauth-test-tokens)
- A free [Mailgun](https://www.mailgun.com/) account
- A server with Python installed

Let's get started.

1. Copy [this file](https://gist.github.com/artnc/83ce08d254d361df9f7bf7a04c9b2649) to your server. It's a tiny Flask app that listens for incoming messages and forwards them to Slack. Edit the values of `SLACK_TOKEN` and `SLACK_CHANNEL` to contain your Slack API token and the desired channel, respectively.

1. Install the app's library dependencies with `pip install Flask requests`. (Optionally, use a [virtual environment](http://docs.python-guide.org/en/latest/dev/virtualenvs/).)

1. Start the app with `python router.py`. It's now listening on port 8003.

1. Go to the [Routes](https://mailgun.com/cp/routes) section of your Mailgun control panel and create a new route with filter expression `catch_all()` and action `forward("http://example.com:8003/mail")`. Replace `example.com` with the public address of your server. (If your server isn't already accessible from the internet, [ngrok](https://ngrok.com/) may come in handy. I use it to host from a Raspberry Pi within my office's LAN.)

1. Go to the [Domains](https://mailgun.com/app/domains) section of your Mailgun control panel and click on the sandbox entry. Take note of the "Default SMTP Login", which looks something like `postmaster@sandbox[...].mailgun.org`.

1. Go into Gmail (or whatever email client you use) and set up email filters that forward incoming messages to the Mailgun address obtained in the previous step.

Any incoming email that matches your filter(s) will now be forwarded to Mailgun, which will in turn forward it to the Flask app running on your server, which will finally forward it to Slack.

Messages from the same sender will always have the same avatar. The message body will consist of the original email's subject line by default; you can customize this behavior in the Flask app.
