---
title: '{{ postbox-full-name }}. Overview'
description: '{{ postbox-full-name }} is a cloud service for simplified and cost-effective email sending.'
---

# {{ postbox-full-name }} overview

{{ postbox-full-name }} is an email service that provides a simple and cost-effective way to send emails from user [addresses](glossary.md#adress) and allows you to flexibly set up delivery [notifications](notification.md).

{{ postbox-name }} is optimized for sending transactional emails, notifications, informational and marketing newsletters, and other types of correspondence. You may choose to unsubscribe from newsletters and forward emails that got answered by users.

You can develop your own software solutions, e.g., generate customer support tickets from incoming emails or build [integrations](#integration) with cloud systems and your own information systems. 

## Integration with other products {#integration}

You can integrate {{ postbox-name }} with other services to:

* Flexibly [differentiate](../security/index.md) employee permissions using the [{{ iam-full-name }}](../../iam/) feature set.
* Send emails from any of your apps.
* Send out newsletters using the [AWS CLI](../tools/aws-cli.md) or [API](../aws-compatible-api/api-ref/) calls.
* Send emails via [SMTP](https://{{ lang }}.wikipedia.org/wiki/SMTP).
* Collect notification [statistics](../operations/logs-write.md) on emails received by {{ postbox-name }}, delivered/not delivered emails.
* Set up email authentication using [DKIM](https://{{ lang }}.wikipedia.org/wiki/DomainKeys_Identified_Mail).
* Create service DNS records in [{{ dns-full-name }}](../../dns/) or with your internet provider.
* Automatically respond to specific letters using [{{ sf-full-name }}](../../functions/).
* [Publish](../tutorials/events-from-postbox-to-yds.md) email sending events to a [{{ yds-full-name }}](../../data-streams/) stream and analyze them using [{{ datalens-full-name }}](../../datalens/).

## Use cases {#examples}

* [{#T}](../tutorials/events-from-postbox-to-yds.md)

#### See also {#see-also}

* [{#T}](../quickstart.md)
* [{#T}](../pricing.md)
