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

{% include [legal-entity-note](../../_includes/notifications/legal-entity-note.md) %}

{% include [individual-sender-description](../../_includes/notifications/individual-sender-description.md) %}

Sender's text name is registered via support.

{% include [registration-duration-warning](../../_includes/notifications/registration-duration-warning.md) %}

{% include [individual-in-sandbox](../../_includes/notifications/individual-in-sandbox.md) %}

#### SMS templates {#templates}

_SMS templates_ help you optimize costs by detecting the type of each SMS notification, which directly affects the [cost](../pricing.md) of sending.

{% include [sms-template-types](../../_includes/notifications/sms-template-types.md) %}

SMS templates are only used in SMS notification channels with an individual sender.

You can [create](../operations/sms/manage-templates.md#create) an SMS template in the [management console]({{ link-console-main }}). Upon creation, the template is assigned the `Registering` [status](#template-status) and submitted for registration with telecom providers. A [support]({{ link-console-support }}) ticket will be created at the same time. Registering a template takes two to four weeks. Once all telecom providers complete template registration, the template switches to the `Active` status.

To delete a template with the `Active` status, you must first [deregister](../operations/sms/manage-templates.md#deregister) it with the telecom providers. In this case, the template status becomes `Deregistering`. Once all telecom providers complete template deregistration, the template switches to the `Deregistered` status, at which point you can [delete](../operations/sms/manage-templates.md#delete-deregistered) the template in {{ cns-name }}.

{% include [sms-template-delete-registering](../../_includes/notifications/sms-template-delete-registering.md) %}

#### Template content {#template-contents}

An SMS template text may contain letters, digits, and special characters^1^. The template text must not:

* Contain any non-standard spaces (e.g., non-breaking spaces).
* Start or end with a space.
* Include two or more consecutive spaces.
* Include special characters beyond those allowed in placeholder elements^1^.

The template may include the following placeholder variables:

#|
||
**Variable** | **Description**
||
||
`%w` {.cell-align-center} | Any continuous sequence of letters, digits, or special characters^1^.
||
||
`%w{1,n}` {.cell-align-center}
|
A limited sequence of one to `n` words, separated by one or more spaces. The following conditions must be met:
* Words may consist of letters, digits, or special characters^1^.
* `n` must be between `2` and `20`.
||
||
`%d` {.cell-align-center} | Any continuous sequence of digits or special characters^1^.
||
||
`%d{1,n}` {.cell-align-center}
|
A limited sequence of one to `n` numbers, separated by one or more spaces. The following conditions must be met:
* Numbers may consist of digits or special characters^1^.
* `n` must be between `2` and `20`.
||
||
`%d+` {.cell-align-center} | A sequence of numbers (digits or special characters^1^), separated by one or more spaces.
||
|#

^1^ Sequences matching `%d` and `%w` may also include the following special characters: `!`, `№`, `#`, `%`, `.`, `,`, `:`, `;`, `?`, `\`, `/`, `(`, `)`, `+`, `-`, `“`, `”`, `―`, `_`, `'`, `"`, `` ` ``, `&`, `^`, `{`, `}`, `[`, `]`, `<`, `>`, and `.|`, `@`, `$`, `=`, `~`, and `*`.

{% note info %}

The `%w+` variable is not allowed.

{% endnote %}

{% cut "SMS template examples" %}

**Transaction template**:

```
Operation: withdrawal of %d RUB. Card *%d. Balance: %d RUB. %w
```

SMS notification example:

```
Operation: withdrawal of 1500 RUB. Card *4321. Balance: 8500 RUB. Store
```

**Service template**:

```
Dear customer! On %d from %d to %d, maintenance work will be performed. The %w service will be unavailable.
```

SMS notification example:

```
Dear customer! On 20/03/2026 from 02:00 to 06:00, maintenance work will be performed. The internet banking service will be unavailable.
```

**Authentication template**:

```
Verification code: %d. Do not share this code with anyone.
```

SMS notification example:

```
Verification code: 123456. Do not share this code with anyone.
```

{% endcut %}

#### Defining the SMS notification type from a template {#sms-type-detection}

When sending an SMS notification, {{ cns-name }} automatically matches the message text to a registered template and applies pricing based on the template type. Only templates with the `Active` [status](#template-status) are considered for matching. When matching a SMS notification text to templates, the following order applies:

* Service notification templates.
* Authentication notification templates.
* Transaction notification templates.

The notification text must exactly match the template, including the character case, the number and type of spaces; also, the text must not contain any undefined special characters.

The SMS type is defined according to the first matching template. If no match is found, the message is classified as promotional.

During [sending](../operations/sms/send.md), you can explicitly specify a template ID using the `CNS.SMS.TemplateARN` attribute. If the message text does not match the specified template, the message will not be sent.

{% note warning %}

Before sending, make sure your SMS text conforms to the intended template.

{% endnote %}

#### Template status {#template-status}

A template can have one of the following statuses:

* `Registering`: Template is being registered with telecom providers.
* `Active`: Template can be used for sending SMS notifications.
* `Deregistering`: Template is being deregistered (unregistered) with telecom providers. Deregistration is required before deleting the template from your {{ cns-name }}.
* `Deregistered`: Deregistration with telecom providers is complete. You can now delete the template in {{ cns-name }}.

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