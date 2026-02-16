---
title: Unsubscribe mechanism
description: One-click unsubscribe mechanism in {{ postbox-full-name }} allows users to unsubscribe from newsletters in just one click.
---

# Unsubscribe mechanism

{{ postbox-name }} supports the `one-click unsubscribe` mechanism implemented under [RFC 8058](https://tools.ietf.org/html/rfc8058). For the mechanism to work correctly, the recipient’s email client must support it.

## What is the unsubscribe mechanism {#overview}

The unsubscribe mechanism is a standardized method that enables email recipients to easily unsubscribe from newsletters. Without such a mechanism, users often mark unwanted emails as spam, which has a negative impact on the sender’s reputation and email deliverability.

One-click unsubscribe solves that problem by giving the recipients a quick way to unsubscribe from a newsletter right in the email client interface, without additional confirmations or the need to go to web pages and fill out forms.

## How to add the unsubscribe mechanism to an email {#implementation}

{% note warning %}

You can only add the unsubscribe mechanism to an email that has one recipient.

{% endnote %}

To activate the unsubscribe mechanism, provide the `ListManagementOptions` parameter when sending the email. The `ListManagementOptions` parameter contains the following attributes:

* `ContactListName`: Name of the contact list associated with the email. Required attribute.
* `TopicName`: Name of the subject within the list of contacts for the user to unsubscribe from. This is an optional attribute.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

    Add the `--list-management-options` parameter, e.g.:

    ```bash
    aws sesv2 send-email \
      --from-email-address mail@example.com \
      --destination file://destination.json \
      --content file://message.json \
      --list-management-options ContactListName=my-list, TopicName=newsletter \
      --endpoint-url https://postbox.cloud.yandex.net
    ```

- SMTP {#smtp}

    Add the `X-SES-LIST-MANAGEMENT-OPTIONS` header, e.g.:

    ```
    X-SES-LIST-MANAGEMENT-OPTIONS: contactListName=my-list
    ```

    If required, you can specify a subject name in `topicName`, e.g.:

    ```
    X-SES-LIST-MANAGEMENT-OPTIONS: contactListName=my-list; topicName=newsletter
    ```

{% endlist %}

## How the unsubscribe mechanism works {#how-it-works}

### Adding headers {#headers}

When you specify the `ListManagementOptions` parameter, {{ postbox-name }} automatically adds two headers to the email:

* `List-Unsubscribe`: Contains an HTTPS unsubscribe link.
* `List-Unsubscribe-Post: List-Unsubscribe=One-Click`: Indicates that unsubscribe is done in one click.

Examples of added headers:

```
List-Unsubscribe: <https://postbox.yandexcloud.net/tracking/v1/unsubscribe?token=...>
List-Unsubscribe-Post: List-Unsubscribe=One-Click
```

### Preserving the existing headers {#existing-headers}

{{ postbox-name }} does not overwrite the `List-Unsubscribe` header if it is already in the email and does not add the `List-Unsubscribe-Post` header.

## Unsubscribe processing {#processing}

When a user clicks **Unsubscribe** in the email client, {{ postbox-name }}:

1. Processes the unsubscribe request.
1. Sends a [notification](notification.md#subscription) if the user is subscribed to notifications.
1. Writes the event information to the execution log.
