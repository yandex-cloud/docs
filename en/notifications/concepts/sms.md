---
title: SMS in {{ cns-full-name }}
description: In this article, you will learn about SMS in {{ cns-name }}, types of senders, and the sandbox.
---

# SMS in {{ cns-full-name }}


{% include [sms-short-description](../../_includes/notifications/sms-short-description.md) %}

{% include [limits-warning](../../_includes/notifications/limits-warning.md) %}

You can create multiple SMS notification channels with different [senders](#senders). One of the channels is set as the default one. This channel will be used to send SMS messages if no channel is specified in the API request or AWS CLI command.

## Senders {#senders}

SMS notification channels can use the following types of senders:
* [Shared sender](#common-sender)
* [Individual senders](#individual-sender)

### Shared sender {#common-sender}

{% include [common-sender-description](../../_includes/notifications/common-sender-description.md) %}

### Individual sender {#individual-sender}

{% include [individual-sender-description](../../_includes/notifications/individual-sender-description.md) %}

Sender's text name is registered via support.

{% include [registration-duration-warning](../../_includes/notifications/registration-duration-warning.md) %}

{% include [individual-in-sandbox](../../_includes/notifications/individual-in-sandbox.md) %}

## Sandbox {#sandbox}

{% include [sandbox-test-numbers](../../_includes/notifications/sandbox-test-numbers.md) %}

You can delete a test phone number 24 hours after adding it. To add this number again, you will need to reconfirm it.

For channels with an individual sender, you can contact support to exit the sandbox mode.

{% include [sms-quota-increase](../../_includes/notifications/sms-quota-increase.md) %}

## See also {#see-also}

* [Service overview](index.md)
* [Getting started with SMS](../quickstart-sms.md)
* [Getting started with the service via the AWS CLI](../tools/aws-cli.md)
* [Push notifications](push.md)