---
title: Terms and definitions in {{ postbox-full-name }}
description: In this article, you will learn about the terms and definitions in {{ postbox-name }}.
---

# Terms and definitions in {{ postbox-name }}

## Address {#adress}

An address is the domain emails are sent from. To send emails from any mailbox on the domain, you need to get your [domain ownership confirmed](../operations/check-domain.md).

To send emails from subdomains, add them as separate addresses. {{ postbox-name }} checks whether the sender’s email domain matches that specified in the address. For example, with `yourdomain.com` as your confirmed ownership domain, you can email from `noreply@yourdomain.com` or `admin@yourdomain.com` but not from `user@mail.yourdomain.com`.

## Configuration {#configuration}

A configuration is a group of [rules](#rules) that can be applied to an outgoing email. If you apply a configuration, all the rules configured within it will apply to your email. You cannot apply individual rules separately.

### Rules {#rules}

A configuration may contain the following rules:

* **{{ ui-key.yacloud.postbox.label_event-destinations }}**: [Notifications about operations with emails](notification.md), e.g., sending, delivery delay, etc. This allows you to redirect notifications about operations to other services for analysis and set up automatic actions in response to selected operations.

* **{{ ui-key.yacloud.postbox.label_delivery-options }}**: Mandatory TLS encryption when emails go from {{ postbox-name }} to recipient servers. Ensures extra data transmission security and protects email contents.

### Applying a configuration to an email {#usage}

You can apply a configuration to an email in the following ways:

* [By associating the configuration with an address](../operations/bind-configuration.md): In this case, the configuration will apply to all emails sent from this address.

    You can associate a configuration only with an address with [domain ownership confirmed](../operations/check-domain.md). One address can be associated with one configuration only; however, one configuration can be associated with more than one address.

* By providing the configuration name in the `X-Ses-Configuration-Set` header.

    The configuration must reside in the same folder as the address. If no configuration of the given name is found in the folder the address is in, you will get an error when sending your email. The configuration provided in the `X-Ses-Configuration-Set` header overrides the configuration associated with the address.

## Sender {#sender}

A sender is a confirmed domain mailbox used to send emails. You can limit the list of allowed senders when [creating](../operations/create-address.md) or editing an address.

## Subscription {#subscription}

A subscription is a destination for [notifications about operations with emails](notification.md).
