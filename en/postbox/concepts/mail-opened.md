---
title: Tracking email openings
description: In {{ postbox-full-name }}, you can track whether recipients open your emails. When the recipient opens the email in their email client, {{ postbox-name }} will send a notification.
---

# Tracking email openings

In {{ postbox-full-name }}, you can track whether recipients open your emails. When the recipient opens the email in their email client, {{ postbox-name }} will send a [notification](notification.md#open).

## How it works {#how-it-works}

To track email openings, {{ postbox-name }} uses the invisible `tracking pixel`. When tracking is enabled, {{ postbox-name }} automatically embeds an invisible 1x1 pixel image at the end of the top HTML part of the email.

As soon as the recipient opens the email in an email client, the client loads the images, including the tracking pixel. {{ postbox-name }} logs the request to load the pixel and sends a notification that the email has been opened.

For a description of the email opening notification format, see [{#T}](notification.md#open).

{% note warning %}

{{ postbox-name }} modifies the email body by adding a tracking pixel.

{% endnote %}

## Setting up tracking {#setup}

To receive notifications about opened emails, [create a configuration](../operations/create-configuration.md) and specify the notification type: **Email opening**.

{% note info %}

Tracking works for emails that have only one recipient.

The tracking pixel is added only to emails containing an HTML part. You cannot use tracking if your email contains only a text part.

{% endnote %}

## Operation specifics {#features}

### Multiple openings {#multiple-opens}

{{ postbox-name }} sends a notification each time a recipient opens your email. If the recipient has opened the email multiple times, you will receive the same number of notifications.

Sometimes, you may get more notifications than the actual number of times the recipient has opened your email for the following reasons:

* The recipient's email client preloads images from emails.
* Your email was exposed to automatic antimalware scanning.
* Other automated processes.

### Caching {#caching}

If the recipient's email client or intermediate servers cache images, repeated openings of the email may not be logged. This depends on the settings of each specific email client.

### Limitations {#limitations}

Tracking email openings may not work accurately in the following cases:

* The recipient has disabled image loading in their email client.
* The email is opened in preview mode without loading images.
* The email client blocks any external images by default.
* The email is opened in text mode.
