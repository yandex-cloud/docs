---
title: Tracking email openings
description: In {{ postbox-full-name }}, you can track whether recipients open your emails. When the recipient opens the email in their email client, {{ postbox-name }} will send a notification.
---

# Tracking email openings

In {{ postbox-full-name }}, you can track whether recipients open your emails. When the recipient opens the email in their email client, {{ postbox-name }} will send a notification.

## How it works {#how-it-works}

To track email openings, {{ postbox-name }} uses a `tracking pixel`. When tracking is enabled, {{ postbox-name }} automatically embeds an invisible 1x1 pixel image at the end of the top HTML part of the email.

As soon as the recipient opens the email in an email client, the client loads the images, including the tracking pixel. {{ postbox-name }} logs the request to load the pixel and sends a notification that the email has been opened.

For a description of the email opening notification format, see [{#T}](notification.md#open).

{% note warning %}

{{ postbox-name }} modifies the email body by adding a tracking pixel.

{% endnote %}

## How to enable {#setup}

You can enable tracking for email openings when [creating](../operations/create-configuration.md) or editing a configuration by using the following methods:

Method | `Openings` [metric](statistics.md#metrics) collection | Sending notifications to {{ yds-name }}
--- | --- | ---
Select the **Email opened** notification type under **{{ ui-key.yacloud.postbox.label_event-destinations }}**. | ![yes](../../_assets/common/yes.svg) | ![yes](../../_assets/common/yes.svg)
Enable **Engagement statistics** under **Statistics collection settings**. | ![yes](../../_assets/common/yes.svg) | ![no](../../_assets/common/no.svg)

{% note info %}

Tracking works for emails with one recipient only.

The tracking pixel is added only to emails containing an HTML part. You cannot use tracking if your email contains only a text part.

{% endnote %}

## Features {#features}

### Multiple openings {#multiple-opens}

{{ postbox-name }} sends a notification each time a recipient opens your email. If the recipient has opened the email several times, you will get as many notifications.

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
