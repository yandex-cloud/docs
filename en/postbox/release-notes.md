---
title: '{{ postbox-full-name }} release notes'
description: This section contains the {{ postbox-name }} release notes.
---

# {{ postbox-full-name }} release notes

## August 2026 {#august-2026}

### Updates {#updates}

* Added support for [dedicated IP addresses](concepts/dedicated-ip.md). You can group dedicated IP addresses into pools and link those pools with [configurations](concepts/configuration.md). All emails to which the configuration applies will be sent from the IP addresses of the pool linked with it. Pool management is available via an [AWS-compatible HTTP API](aws-compatible-api/api-ref/index.md#dedicated-ips) and the AWS CLI.
* Added support for the [custom suppression list](concepts/suppression-list.md#user).

## July 2026 {#july-2026}

### Updates {#updates}

* Added support for the [email delivery simulator](concepts/mail-simulator.md).
* Added support for the `SPAM` status for emails.

## June 2026 {#june-2026}

### Updates {#updates}

* Supported [bulk emails](aws-compatible-api/api-ref/send-bulk-email.md) via the AWS-compatible HTTP API. The `SendBulkEmail` method now allows you to send multiple templated emails in a single request, with a common template and individual substitution data, recipients, headers, and labels for each email.
* Added support for attachments in emails sent via the AWS-compatible HTTP API. Files are provided in the `Attachments` parameter:

    * In the [SendEmail](aws-compatible-api/api-ref/send-email.md) method, via the `Simple` or `Template` content type.
    * In the [SendBulkEmail](aws-compatible-api/api-ref/send-bulk-email.md) method, via the shared `DefaultContent.Template` content.

    Both regular attachments and inline attachments (e.g., images in HTML) are supported. Read more on [attachment limitations](concepts/restrictions.md).

## April 2026 {#april-2026}

### Updates {#updates}

* Added support for the full-cycle processing of email complaints: accepting complaints from internet service providers, parsing these complaints, identifying the sender, and sending a [complaint notification](concepts/notification.md#complaint) to the user. Added a dedicated complaints metric to the [statistics](concepts/statistics.md) on sent emails in the management console.
* Added support for [viewing](operations/messages.md) information about sent emails in the management console.

## February 2026 {#february-2026}

### Updates {#updates}

* Added support for the simple method of setting up a DKIM signature (Easy DKIM).

## October 2025 {#october-2025}

### Updates {#updates}

* Added support for the sender list limit: now, when [creating an address](operations/create-address.md), you can also add the list of mailboxes allowed to send to it.

## September 2025 {#september-2025}

### Updates {#updates}

* Added graph [statistics](concepts/statistics.md) to track email deliveries, opens, link clicks, and unsubscribes.

## August 2025 {#august-2025}

### Updates {#updates}

* Added support for [click tracking](concepts/click-tracking.md) in emails.

## July 2025 {#july-2025}

### Updates {#updates}

* Supported [authentication with an {{ iam-short-name }} token](api-ref/authentication.md#iam-ses-example).
* Supported notifications about the following events:
    * [Email opened](concepts/notification.md#open)
    * [Email delivery delayed](concepts/notification.md#delayed-delivery)
    * [Recipient unsubscribed](concepts/notification.md#subscription)
* Supported [email delivery over a secure connection](aws-compatible-api/api-ref/put-configuration-set-delivery-options.md).

## May 2025 {#may-2025}

### Updates {#updates}

* Added support for {{ TF }}: you can now create addresses and check custom domain ownership using {{ TF }}. Read more in [this article](tutorials/domain-identity-creating.md).

## March 2025 {#march-2025}

### Updates {#updates}

* Added support for SMTPS: users whose email client does not support STARTTLS can now send emails using {{ postbox-full-name }}.
* Added support for [email templating](operations/send-templated-email.md).

## January 2025 {#january-2025}

### Updates {#updates}

* Added support for sending [notifications about email delivery](concepts/notification.md) to a {{ yds-full-name }} data stream.
* Added support for [API key authentication](operations/send-email.md#smtp) when sending emails from the email client over SMTP.

## August 2024 {#august-2024}

### Updates {#updates}

* Added support for [logging](operations/logs-write.md) to the execution log.
