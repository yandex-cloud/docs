---
title: Email delivery simulator
description: The {{ postbox-full-name }} email delivery simulator allows you to test successful delivery and delivery error processing without emailing an actual recipient.
---

# Email delivery simulator

The email delivery simulator is a set of special {{ postbox-full-name }} addresses that simulate different email delivery outcomes.

You can email to the simulator address using any method supported by {{ postbox-name }}: SMTP or an [AWS-compatible API](../aws-compatible-api/).

## Available addresses {#scenarios}

#|
|| **Address** | **Scenario** | **Description** ||
|| `success@simulator.pstbx.ru` | Successful delivery | {{ postbox-name }} accepts the email as delivered. ||
|| `bounce@simulator.pstbx.ru` | Delivery error | The simulator's mail server returns the `452 4.2.2 The recipient's inbox is out of storage space` SMTP response. ||
|| `delay@simulator.pstbx.ru` | Delivery delayed | {{ postbox-name }} fails to deliver the email due to a temporary error, sends a [delivery delayed notification](notification.md#delayed-delivery), and retries delivery. ||
|| `suppressed@simulator.pstbx.ru` | Recipient on suppression list | {{ postbox-name }} does not attempt to deliver the email and sends a [delivery error notification](notification.md#bounce) with the `Suppressed` subtype, as if the recipient address were on the suppression list. ||
|#

## How to use {#usage}

1. Get ready to send an email using one of the methods described in [{#T}](../operations/send-email.md).
1. Specify the simulator address for your preferred scenario as a recipient.
1. Send an email.
1. Check the result:
   * In [email operation notifications](notification.md) if your email [uses](configuration.md#usage) a subscription configuration.
   * In the [statistics](statistics.md).
   * In the [execution log](../operations/logs-write.md) if transitions between email statuses are logged for the address.
   * In [sent history](../operations/messages.md).

#### Useful links {#see-also}

* [{#T}](../operations/send-email.md)
* [{#T}](notification.md)
* [{#T}](statistics.md)
* [{#T}](../operations/logs-write.md)
* [{#T}](../operations/messages.md)
