---
title: Postbox integration step
description: This article describes the fields for the Postbox integration step.
---

# Postbox

{% include [workflows-ai-studio-note](../../../../../_includes/serverless-integrations/workflows-ai-studio-note.md) %}

Sending emails with {{ postbox-full-name }}. The `simple` and `raw` fields are mutually exclusive.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`fromAddress` | `string` | Yes | None | None | {{ postbox-name }} [address](../../../../../postbox/concepts/glossary.md#adress) to send emails from.<br/><br/>[The service account](../../../../../iam/concepts/users/service-accounts.md) specified in the [workflow](../../workflow.md) settings and the address specified in this field must reside in the same [folder](../../../../../resource-manager/concepts/resources-hierarchy.md#folder).
`destination` | [Destination](#postbox-destination) | Yes | None | None | Object describing addresses of recipients.
`simple` | [SimpleMessage](#postbox-simplemessage) | None | None | None | Email that will be sent.
`raw` | [RawMessage](#postbox-rawmessage) | None | None | None | Email that will be sent.

## Destination {#postbox-destination}

After templating, the field values must have this format: `a@example.com, b@example.com` or `[a@example.com, b@example.com]`.

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`toAddresses` | `string` | Yes | None | Yes | Addresses of email recipients.
`ccAdresses` | `string` | None | None | Yes | Addresses of email copy recipients.

## RawMessage {#postbox-rawmessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`data` | `string` | Yes | None | Yes | Raw email type. For more information, see [this {{ postbox-name }} guide](../../../../../postbox/aws-compatible-api/api-ref/send-email.md).

## SimpleMessage {#postbox-simplemessage}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`subject` | [MessageData](#postbox-messagedata) | Yes | None | None | Email subject.
`body` | [Body](#postbox-body) | Yes | None | None | Email text.

## Body {#postbox-body}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`text` | [MessageData](#postbox-messagedata) | Yes | None | None | Object in charge of displaying the email in mail clients without HTML support.
`html` | [MessageData](#postbox-messagedata) | Yes | None | None | Object in charge of displaying the email in mail clients with HTML support.

## MessageData {#postbox-messagedata}

Field name | Type | Required | Default value | [Templating](../../templating.md) supported | Description
--- | --- | --- | --- | --- | ---
`data` | `string` | Yes | None | Yes | Text.
`charset` | `UTF_8`\|<br/>`ISO_8859_1`\|<br/>`Shift_JIS` | Yes | None | None | Encoding: