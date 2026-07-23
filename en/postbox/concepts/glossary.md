---
title: Terms and definitions in {{ postbox-full-name }}
description: In this article, you will learn about the terms and definitions in {{ postbox-name }}.
---

# Terms and definitions in {{ postbox-name }}

## Address {#adress}

An address is the domain emails are sent from. To send emails from any mailbox on the domain, you need to get your [domain ownership confirmed](../operations/check-domain.md).

To send emails from subdomains, add them as separate addresses. {{ postbox-name }} checks whether the sender’s email domain matches that specified in the address. For example, with `yourdomain.com` as your confirmed ownership domain, you can email from `noreply@yourdomain.com` or `admin@yourdomain.com` but not from `user@mail.yourdomain.com`.

## Configuration {#configuration}

A configuration is a group of rules you can apply to an outgoing email. A configuration may contain the following rules:
* Getting email event notifications.
* Configuring mandatory TLS encryption.
* Collecting engagement statistics.

For more information, see [{#T}](configuration.md).

## Sender {#sender}

A sender is a confirmed domain mailbox used to send emails. You can [limit the list of allowed senders](../../postbox/operations/restrict-senders.md) when creating or editing an address.

## Subscription {#subscription}

A subscription is a destination for [notifications about operations with emails](notification.md).

## DKIM signature {#dkim}

{% include [dkim](../../_includes/postbox/dkim.md) %}

{{ postbox-name }} supports Easy DKIM and the advanced DKIM settings. For more information, see [{#T}](dns-records.md#dkim).
