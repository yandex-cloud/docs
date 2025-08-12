# Email event notifications

To get email event notifications, [create a configuration](../operations/create-configuration.md) and [associate it with your address](../operations/bind-configuration.md).

## Notification types {#types}

### Notification of email acceptance by the service {#send}

Comes when {{ postbox-name }} has accepted the email for processing.

Notification example:

```json
{
    "eventType": "Send",
    "mail": {
        "timestamp": "2024-04-25T18:05:04.84108+03:00",
        "messageId": "vgAyRUls8591ybPKeH-Ov",
        "identityId": "nWh0ZpVEgnKO1bghxydXn",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"vgAyRUls8591ybPKeH-Ov",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "tags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ],
        }
    },
    "send": {  },
    "eventId": "vgAyRUls8591ybPKeH-Ov:0"
}
```

### Email delivered notification {#delivery}

Comes when the email was sent and the recipient's email client has confirmed acceptance.

Notification example:

```json
{
    "eventType": "Delivery",
    "mail": {
        "timestamp": "2024-04-25T18:05:04.84108+03:00",
        "messageId": "vgAyRUls8591ybPKeH-Ov",
        "identityId": "nWh0ZpVEgnKO1bghxydXn",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"vgAyRUls8591ybPKeH-Ov",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "tags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ],
        }
    },
    "bounce": null,
    "delivery": {
        "timestamp": "2024-04-25T18:05:14.84107+03:00",
        "processingTimeMillis": 9999,
        "recipients": [
            "abc@example.com"
        ]
    },
    "eventId": "ce3uqnS9pzQBMsnaAbrT_:0"
}
```

### Email not delivered notification {#bounce}

Comes when the recipient's email client responds to a delivery attempt with an error which, according to {{ postbox-name }}, does not require another delivery attempt, or when the recipient's address is on the stop list.

Notification example:

```json
{
    "eventType": "Bounce",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "tags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ],
        }
    },
    "bounce": {
        "bounceType": "Permanent",
        "bounceSubType": "Undetermined",
        "bouncedRecipients": [
            {
                "emailAddress": "abc@example.com",
                "action": "failed",
                "status": "5.7.1",
                "diagnosticCode": "Other"
            }
        ],
        "timestamp": "2024-04-25T18:08:04.973666+03:00",
    },
    "delivery": null,
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Email open notification {#open}

You get this type of notification when the recipient opens the email.

Notification example:

```json
{
    "eventType": "Open",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "tags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ],
        }
    },
    "open": {
        "ipAddress": "192.0.2.1",
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Delayed email delivery notification {#delayed-delivery}

Once successfully accepted by {{ postbox-name }}, the email is normally sent it right away. However, a slight delay in delivery may sometimes occur. It is in this case that you receive this type of notification.

Notification example:

```json
{
    "eventType": "DeliveryDelay",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "tags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ],
        }
    },
    "deliveryDelay": {
        "delayType": "General",
        "delayedRecipients": [
            {
                "emailAddress": "recipient@example.com"
            }
        ],
        "timestamp": "2024-04-25T18:10:04.973666+03:00"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Recipient unsubscribe notification {#subscription}

You get this type of notification when the recipient uses `one-click unsubscribe` that {{ postbox-name }} adds to emails.

Notification example:

```json
{
    "eventType": "Unsubscribe",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using Yandex Cloud Postbox"
        },
        "tags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ],
        }
    },
    "subscription": {
        "contactList": "my-list",
        "timestamp": "2024-04-25T18:08:04.973666+03:00",
        "source": "UnsubscribeHeader"
    }
}
```

## Notification format {#format}

The notification is written to the {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in JSON format. The list and sequence of fields may differ from those described below.

### Main object {#main-object}

Name | Type | Description
--- | --- | ---
`notificationType` | String | [Notification type](#types). The possible values are `Bounce`, `Delivery`, and `Send`.
`mail` | [Mail](#mail-object) object | Object containing general information about the sent email.
`bounce` | [Bounce](#bounce-object) object | Object containing information that the email has not been delivered. Required if the `notificationType` is `Bounce`; otherwise, not present.
`delivery` | [Delivery](#delivery-object) object | Object containing information about the email being delivered to an individual recipient. Required if the `notificationType` is `Delivery`; otherwise, not present.
`subscription` | [Subscription](#subscription-object) object | Object containing information that the recipient has unsubscribed from the mailing list. Required if the `notificationType` is `Subscription`; otherwise, not present.
`open` | [Open](#open-object) object | Object containing information that the email has been opened. Required if the `notificationType` is `Open`; otherwise, not present.
`eventId` | String | Unique ID of the event.

### Mail object {#mail-object}

Name | Type | Description
--- | --- | ---
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the email was accepted by {{ postbox-name }}.
`messageId` | String | Unique ID of the email. One email can have multiple recipients. Sent by {{ postbox-name }} when accepting the email for processing.
`identityId` | String | ID of the {{ postbox-name }} address used when sending the email.
`commonHeaders` | [CommonHeaders](#common-headers-object) object | Object containing the main headers of the email.
`tags` | Object | Object containing tags added to the email.

### CommonHeaders object {#common-headers-object}

Name | Type | Description
--- | --- | ---
`from` | Array of strings | Contents of the `From` header, broken down by address.
`to` | Array of strings | Contents of the `To` header, broken down by address.
`subject` | String | Contents of the `Subject` header.
`date` | String | Contents of the `Date` header.
`messageId` | String | Unique ID of the email. Sent by {{ postbox-name }} when accepting the email.

### Send object {#send-object}

Empty object.

### Bounce object {#bounce-object}

Name | Type | Description
--- | --- | ---
`bounceType` | String | Error type. The possible values are:<ul><li>`Permenent`: Email not delivered.</li></ul>
`bounceSubType` | String | Error subtype. The possible values are:<ul><li>`Undetermined`: Unknown error.</li><li>`Suppressed`: Email not delivered because the recipient is on the stop list.</li></ul>
`bouncedRecipients` | Array of [BounceRecipient](#bounce-recipent-object) objects | Array containing information about the email recipient and the related delivery error, if any.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the error was received from the recipient's email client.

### BounceRecipient object {#bounce-recipent-object}

Name | Type | Description
--- | --- | ---
`emailAddress` | String | Recipient's email address.
`action` | String | Optional field. Result of sending. The possible value is `failed`.
`status` | String | Optional field. SMTP response code.
`diagnosticCode` | String | Optional field. Extended error text. May contain error text from the recipient's email client.

### Delivery object {#delivery-object}

Name | Type | Description
--- | --- | ---
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time when {{ postbox-name }} sent the email and received a successful response from the recipient's email client.
`processingTimeMillis` | Integer | Time spent to process the email in milliseconds.
`recipients` | Array of strings | Addresses of recipients.

### DeliveryDelay object {#delivery-delay-object}

Name | Type | Description
--- | --- | ---
`delayType` | String | Delay type. The possible value is `General`.
`delayedRecipients` | [DelayedRecipient](#delayed-recipient-object) object array | Array containing information about the email recipient and the related delivery delay.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Delivery delay timestamp.

### DelayedRecipient object {#delayed-recipient-object}

Name | Type | Description
--- | --- | ---
`emailAddress` | String | Recipient's email address.

### Subscription object {#subscription-object}

Name | Type | Description
--- | --- | ---
`contactList` | String | Name of the contact list associated with the email.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Recipient unsubscribe timestamp.
`source` | String | Unsubscribe source. The possible value is `UnsubscribeHeader`.

### Open object {#open-object}

Name | Type | Description
--- | --- | ---
`ipAddress` | String | Recipient IP address.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Email opening timestamp.
`userAgent` | String | Identification string (`User-Agent`) of the device or email the client used to open the email.

## Quality of service (QoS) level {#qos}

To deliver notifications, the service supports the `QoS 1: At least once` quality of service level, so it is possible to resend notifications. Identical notifications have the same `eventId`.

If an address is linked to a [configuration](glossary.md#configuration) that has multiple [subscriptions](glossary.md#subscription.md) added to it, a separate notification will come for each assignment.

## Use case {#example}

You sent an email to two recipients: `user1@example.com` and `user2@other.example.com`. {{ postbox-name }} sent it to both recipients separately.

The email client of `user1@example.com` accepted the email. The email client of the recipient `user2@other.example.com` returned an error after the first attempt to send the email and declined to accept the email after the second attempt, replying that the user was not found.

In which case you will get these three notifications:
* Notification that {{ postbox-name }} accepted the email for processing.
* Notification that the email was delivered to `user1@example.com`.
* Notification that the email was not delivered to `user2@other.example.com` with the error info. The notification will come after the second attempt to send the email.

Since the mail client responded that the recipient `user2@other.example.com` was not found, the address will be temporarily put on the stop list. You should wait for some time before trying to reach the address again, otherwise you will get notified that your message was not delivered because the recipient was on the stop list. 
