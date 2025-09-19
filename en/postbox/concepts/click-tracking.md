---
title: Click tracking
description: In {{ postbox-full-name }}, you can track clicks in emails. As soon as the recipient clicks a link in an email, {{ postbox-name }} notifies you accordingly.
---

# Click tracking

In {{ postbox-full-name }}, you can track clicks in emails. As soon as the recipient clicks a link in an email, {{ postbox-name }} [notifies](notification.md#click) you accordingly.

## How it works {#how-it-works}

{{ postbox-name }} uses link redirection technology for click tracking. With click tracking on, the system automatically replaces all links in the HTML part of the email with tracking links routed through an intermediate {{ postbox-name }} server.

When the recipient clicks a link, the browser first sends a request to the {{ postbox-name }} server. The server logs the click and sends a notification and then redirects the user to the original URL.

For details on click notification format, see [{#T}](notification.md#click).

{% note warning %}

{{ postbox-name }} modifies the email body by replacing original links with tracking links. The tracking link protocol is the same as the original link protocol (e.g., `http://` or `https://`).

{% endnote %}

## Setting up tracking {#setup}

To receive click notifications, [create a configuration](../operations/create-configuration.md) and select the **Click** notification type.

{% note info %}

Tracking works for emails with one recipient only.

Tracking links are added only to emails containing the HTML part. You cannot use tracking if your email contains only the text part.

{% endnote %}

## Operational aspects {#features}

### Multiple clicks {#multiple-clicks}

{{ postbox-name }} sends a notification each time the recipient clicks a link. If the recipient has clicked a link several times, you will get as many notifications.

### Supported protocols {#protocols}

Link tracking supports the following protocols:

* `http://`
* `https://`

Links with other protocols (`mailto:`, `tel:`, `ftp://`, etc.) are not tracked and remain unchanged.

{{ postbox-name }} automatically prepends the default `http://` protocol to links without a protocol (e.g., `www.example.com`).

### Error handling {#error-handling}

If the original link cannot be reached or returns an error, {{ postbox-name }} will send a click notification anyway, and the user will get notified of the error in the browser.

### Link tags {#link-tags}

You can add key-value tags to links in your email using the `postbox:tags` attribute. When using this attribute, specify keys in `<key>:<value>` format. To provide several key-value pairs, separate them with semicolons (`;`).

For example, if adding the tags `product:book`, `genre:fiction`, `subgenre:scifi`, `type:newrelease`, the resulting link will look like this:

```html
<a postbox:tags="product:book;genre:fiction;subgenre:scifi;type:newrelease;"
   href="http://www.example.com/…/">New science fiction releases</a>
```

Tags are delivered into click notifications, thus enabling additional analysis of particular links clicked by users. You can use tags to distinguish between clicking the same links in different parts of the email. Replacing original links with tracking links removes tags, so you cannot see them in the email.
