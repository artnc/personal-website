---
h1: How to Use a Custom Email Domain with Gmail
layout: post
pagetitle: How to Use a Custom Email Domain with Gmail
tags: []
---

Here's exactly what I did to set up my own `firstname@lastname.com` email address in Gmail, allowing me to seamlessly use that new address with my existing Gmail account:

![](/img/gmail-from.png)

This process takes an hour or two and costs around $10/year.

1. Create a personal [Gmail](https://www.google.com/gmail/about/) account if you don't already have one
   - Optional: go to gear icon > Settings > Images and disable automatic image loading. You know how some chat apps have read receipts? Well it turns out that nosy email senders (e.g. spammers) often use inline images in a similar way to [determine](https://www.wired.com/2013/12/turn-gmail-auto-image-loading-off/) whether the recipient has opened their message.<br><br>![](/img/gmail-images.png)
1. Buy a domain name at [Namecheap](https://www.namecheap.com/), e.g. `chaidarun.com`
   - Try to get a `.com` for the credibility and familiarity. You _could_ get a `.org` or `.net` if your preferred `.com` isn't available, but then you run the risk of people forgetting and trying to email you at `.com` anyway.
   - This is the only step that costs money!<br><br>![](/img/namecheap-domain.png)
1. Go to your Namecheap account > Profile > [Settings](https://ap.www.namecheap.com/settings/security) and enable 2FA
   - By default, Namecheap sends a verification code to your `@gmail.com` address whenever you try to log in. Enabling 2FA via either TOTP or Yubikey will replace that step, removing the dependency on your old address&mdash;more on this [later](#why-you-need-a-custom-email-domain).
1. Create a free [Cloudflare](https://www.cloudflare.com/) account and "Add a Site" for your new domain
   - Like me, you might already be using their free CDN on your personal website. You should just reuse your existing site entry if your desired custom email address will be on the same domain.
1. Go to your Cloudflare site's dashboard > DNS and take note of your nameservers<br><br>![](/img/cloudflare-nameservers.png)
1. Go back to your Namecheap account > [Domain List](https://ap.www.namecheap.com/domains/list/) > Manage > Nameservers > Custom DNS and enter in those nameserver values
   - [DNS](https://en.wikipedia.org/wiki/Domain_Name_System) is like the internet's phonebook system. DNS _records_ are pieces of metadata associated with a given domain name, similar to how a phonebook associates your phone number and home address with your full name. By pointing your domain to Cloudflare's nameservers, you tell the entire internet to consult Cloudflare as the keeper of your domain's metadata.<br><br>![](/img/namecheap-nameservers.png)
1. Go back to your Cloudflare site dashboard > Email and enable email routing
   - This is the point at which you actually choose your new custom address, e.g. `firstname@lastname.com`<br><br>![](/img/cloudflare-routing.png)
   - Routing solves the easy half of the email equation: _receiving_ email at your new address. The rest of this guide tackles _sending_ email from your new address.
1. Create a free [SMTP2GO](https://www.smtp2go.com/) account
   - This is [SMTP](https://en.wikipedia.org/wiki/Simple_Mail_Transfer_Protocol) as a service, similar to SendGrid and Mailgun and Mailjet and Amazon SES and many many more. Businesses normally use these services to blast out _transactional_ (i.e. marketing) emails, but they also handle personal email perfectly fine. It makes little difference which SMTP service you choose&mdash;I went with SMTP2GO as [recommended](https://www.reddit.com/r/selfhosted/comments/wt88z6/what_is_the_best_free_smtp_solution_to_use_with/) on Hacker News and Reddit.
   - You don't really need to know anything about SMTP servers beyond the fact that you need one in order to send email.
1. At SMTP2GO > Settings > Verified Senders, add your domain as a sender domain
1. Go to your Cloudflare site dashboard > DNS<br><br>![](/img/smtp.png)
1. Go to SMTP2GO > Settings > SMTP Users and "Add SMTP user" with default settings<br><br>![](/img/smtp2go-users.png)
1. Go to Gmail > gear icon > Settings > Accounts and Import > Send mail as > Add another email address, uncheck "Treat as an alias", and enter the connection details from the previous step
   - Some other guides online will tell you to use Gmail's own `smtp.gmail.com` here, which mostly works and is slightly easier than setting up SMTP2GO. The problem there is that Gmail's SMTP server won't sign outgoing mail from your new address with [DKIM](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail), increasing the likelihood that your messages will get marked as spam. Services like SMTP2GO do handle DKIM, [SPF](https://en.wikipedia.org/wiki/Sender_Policy_Framework), etc.<br><br>![](/img/gmail-smtp.png)
1. Add your new email address to your Google account as an [alternate email](https://myaccount.google.com/email)
   - Profile pictures are a Gmail thing, not an email thing. Gmail users will find it sketchy if you send them a faceless email from your new address, so how do you tell Google what picture to show them? Setting your new address as an alternate email in your Google account will cause Gmail recipients to see your Google photo even when you email them from your non-Gmail address.<br><br>![](/img/google-alternate-email.png)
1. Verify reliable deliverability with tools like [Mail Tester](https://www.mail-tester.com/) and [Learn DMARC](https://www.learndmarc.com/).<br><br>![](/img/mail-tester.png)<br>![](/img/learndmarc.png)

Congrats, you did it! Now to explain some decisions above in more detail...

## Why you need a custom email domain

Email is just one of many ways to communicate online, while your email _address_ is your entire online identity. If you accidentally delete all your email messages, that's a bummer but not too bad. If you ever lose control of your email address, which is tied to your accounts on dozens (if not hundreds) of other websites, that's catastrophic.

In the worst case, someone takes over your Gmail and now has access to your other online accounts via password reset. In a hopefully more likely scenario, you might simply want to change email providers without needing to also update all your online accounts and human contacts. Gmail is popular today, but remember Hotmail and Yahoo Mail?

By decoupling your email address from your email provider, you retain ownership of your own identity.

## Why you should still use Gmail

Once you fully own your email address, the choice of email provider becomes less important. Gmail is still perfectly fine for the actual handling of email&mdash;it filters spam with surgical precision, it tends to have better features than competitors, and it costs $0.

Privacy-conscious people might balk at giving their emails to the world's largest advertising company, who also happens to be a world leader in artificial intelligence. That's a reasonable take, but a few counterpoints worth considering:

- Google [already has access](https://mako.cc/copyrighteous/google-has-most-of-my-email-because-it-has-all-of-yours) to all of your email communications with Gmail users
- Google has likely [become so good](https://techcrunch.com/2017/06/23/google-has-all-the-data-it-needs-will-stop-scanning-gmail-inboxes/) at ad targeting that they don't even need to read your emails anymore
- Gmail-to-Gmail messaging is arguably _more_ secure than, say, Fastmail-to-Gmail since the data never leaves Google servers to travel across the open internet
- Email is [fundamentally insecure](https://security.stackexchange.com/a/30094) anyway

## Why you shouldn't worry about email privacy

Generally speaking, it's a lost cause. Email was invented over half a century ago without any thought given to privacy or security&mdash;it's the digital equivalent of [postcards](https://www.ias.edu/security/would-you-send-postcard-mail). Would you write your credit card info on a postcard, visible to your landlord and your nosy neighbors and who knows how many random postal workers? This is why your bank never emails you sensitive information. Instead, banks go to the trouble of building email-like communication channels on their own websites for customers.

If you _really_ need email privacy because you're a whistleblower or journalist then there's [PGP](https://www.maketecheasier.com/pgp-encryption-how-it-works/), but that's hardly the normal use case for email. Extremely few people know how insecure email is, let alone care about it, let alone are willing to jump through user-unfriendly hoops like PGP or ProtonMail, let alone talk to people who also choose to jump those same hoops.

For the vast majority of ordinary people who just want their private messages with friends and family to actually be private, chat apps like [Signal](https://signal.org/en/) easily beat email. If Signal itself is too hard a sell (fair enough), WhatsApp and Google Messages are more popular alternatives that use the same end-to-end [encryption technology](https://en.wikipedia.org/wiki/Signal_Protocol) created by Signal.

---

References:

- [https://clr.is/articles/custom_email/](https://clr.is/articles/custom_email/)
- [https://news.ycombinator.com/item?id=30443399](https://news.ycombinator.com/item?id=30443399)
- [https://jay.gooby.org/2022/05/06/use-a-basic-gmail-account-to-send-mail-as-with-a-domain-that-uses-cloudflare-email-routing](https://jay.gooby.org/2022/05/06/use-a-basic-gmail-account-to-send-mail-as-with-a-domain-that-uses-cloudflare-email-routing)
- [https://sales.rocks/blog/set-up-profile-picture-in-gmail-from-different-domains/](https://sales.rocks/blog/set-up-profile-picture-in-gmail-from-different-domains/)
- [https://piszek.com/2022/01/23/gmail-custom-domain-free/](https://piszek.com/2022/01/23/gmail-custom-domain-free/)
- [https://sneak.berlin/20201029/stop-emailing-like-a-rube/](https://sneak.berlin/20201029/stop-emailing-like-a-rube/)
