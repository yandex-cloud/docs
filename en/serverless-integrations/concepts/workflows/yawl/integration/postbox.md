---
title: Postbox integration step
description: This article describes the fields for the Postbox integration step.
---

# Postbox

Sending emails with {{ postbox-full-name }}. The `simple` and `raw` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`fromAddress` | `string` | Yes | No | No | {{ postbox-name }} [address](../../../../../postbox/concepts/glossary.md#adress) to send emails from.<br/><br/>The [service account](../../../../../iam/concepts/users/service-accounts.md) specified in the [workflow](../../workflow.md) settings and the address specified in this field must reside in the same [folder](../../../../../resource-manager/concepts/resources-hierarchy.md#folder).
`destination` | [Destination](#postbox-destination) | Yes | No | No | Object describing addresses of recipients.
`simple` | [SimpleMessage](#postbox-simplemessage) | No | No | No | Email that will be sent.
`raw` | [RawMessage](#postbox-rawmessage) | No | No | No | Email that will be sent.

## Destination {#postbox-destination}

After templating, the field values must have this format: `a@example.com, b@example.com` or `[a@example.com, b@example.com]`.

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`toAddresses` | `string` | Yes | No | Yes | Addresses of email recipients.
`ccAdresses` | `string` | No | No | Yes | Addresses of email copy recipients.

## RawMessage {#postbox-rawmessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`data` | `string` | Yes | No | Yes | Raw email type. For more information, see the [{{ postbox-name }} documentation](../../../../../postbox/aws-compatible-api/api-ref/send-email.md).

## SimpleMessage {#postbox-simplemessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`subject` | [MessageData](#postbox-messagedata) | Yes | No | No | Email subject.
`body` | [Body](#postbox-body) | Yes | No | No | Email text.

## Body {#postbox-body}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`text` | [MessageData](#postbox-messagedata) | Yes | No | No | Object in charge of displaying the email in mail clients without HTML support.
`html` | [MessageData](#postbox-messagedata) | Yes | No | No | Object in charge of displaying the email in mail clients with HTML support.

## MessageData {#postbox-messagedata}

Field name | Type | Required | Default value | [Templating](../../templating.md) is supported | Description
--- | --- | --- | --- | --- | ---
`data` | `string` | Yes | No | Yes | Text.
`charset` | `UTF_8`\|<br/>`ISO_8859_1`\|<br/>`Shift_JIS` | Yes | No | No | Encoding: