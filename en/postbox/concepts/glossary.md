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

* **Statistics collection settings**: Settings for collection of statistics on [email opens](mail-opened.md) and [clicks](click-tracking.md). They enable automatically collecting and analyzing the `Openings` and `Clicks` [metrics](statistics.md#metrics).

### Email delivery options with mandatory TLS encryption on {#delivery-options}

For emails from the client to {{ postbox-name }}, a secure TLS connection is used at all times. The transmission protocol depends on the sending method:
* HTTPS: If using an Amazon API compatible [API](../api-ref/authentication.md).
* SMTP over TLS: If using port `465`.
* STARTTLS: If using port `587`.

The **{{ ui-key.yacloud.postbox.label_delivery-options }}** option:
* With **{{ ui-key.yacloud.postbox.label_delivery-options }}** off, {{ postbox-name }} will still try to use TLS to send emails. If there is a TLS error or the recipient's server does not support TLS, the email will be sent unencrypted.
* With **{{ ui-key.yacloud.postbox.label_delivery-options }}** on, {{ postbox-name }} will require a valid TLS certificate issued by a trusted CA and support for the minimum TLS version specified in the configuration settings. If the recipient's server does not meet these requirements, the email will not be delivered, and you will get a non-delivery notification.

{% note warning %}

Before you enable this option, make sure the recipient's servers are TLS compliant. If you are not sure that all the recipients' servers are configured correctly and want to prioritize email deliverability, it is best to keep this option off.

{% endnote %}

#|
|| **Recipient's server issue** | **Mandatory TLS encryption off** | **Mandatory TLS encryption on** | > ||
|| ^ | ^ | **Minimum TLS version 1.0** | **Minimum TLS version 1.2** ||
|| The server does not support TLS | Email delivered without TLS encryption | Email not delivered {.cell-align-center} | > ||
|| The server supports only TLS 1.0/1.1 | Email delivered with TLS 1.0/1.1 {.cell-align-center} | > | Email not delivered ||
|| The server supports TLS 1.2 and higher with a valid certificate | Email delivered with the highest TLS version the client and server could agree on {.cell-align-center} | > | > ||
|| Expired TLS certificate | Email delivered with TLS encryption {.cell-align-center} | Email not delivered {.cell-align-center} | > ||
|| Self-signed certificate | ^ | ^ | > ||
|#

### Applying a configuration to an email {#usage}

You can apply a configuration to an email using the following methods:

* [By associating the configuration with an address](../operations/bind-configuration.md): In this case, the configuration will apply to all emails sent from this address.

    You can associate a configuration only with an address with [domain ownership confirmed](../operations/check-domain.md). One address can be associated with one configuration only; however, one configuration can be associated with more than one address.

* By providing the configuration name in the `X-Ses-Configuration-Set` header.

    The configuration must reside in the same folder as the address. If no configuration of the given name is found in the folder the address is in, you will get an error when sending your email. The configuration provided in the `X-Ses-Configuration-Set` header overrides the configuration associated with the address.

* By providing the configuration name in the `ConfigurationSetName` field, if using the AWS-compatible API [`SendEmail` method](../aws-compatible-api/api-ref/send-email).

    The configuration must reside in the same folder as the address. If no configuration of the given name is found in the folder the address is in, you will get an error when sending your email. The configuration provided in the `X-Ses-Configuration-Set` field overrides the configuration associated with the address.

{% note info %}

The configuration settings are applied to the email the moment you send it. If you change the configuration settings after sending, the change will not affect the emails that are sent but not yet delivered.

{% endnote %}

## Sender {#sender}

A sender is a confirmed domain mailbox used to send emails. You can limit the list of allowed senders when [creating](../operations/create-address.md) or editing an address.

## Subscription {#subscription}

A subscription is a destination for [notifications about operations with emails](notification.md).
