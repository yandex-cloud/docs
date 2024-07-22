# Email delivery notifications

To get email delivery notifications, [create a configuration](../operations/create-configuration.md) and [link it to your address](../operations/bind-configuration.md).

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

## Notification format {#format}

The notification is written to the {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in JSON format. The list and sequence of fields may differ from those described below.

### Main object {#main-object}

| Name | Type | Description |
--- | --- | ---
| `notificationType` | String | [Notification type](#types). Possible values: `Bounce`, `Delivery`, `Send`. |
| `mail` | [Mail](#mail-object) object | Object containing general information about the sent email. |
| `bounce` | [Bounce](#bounce-object) object | Object containing information that the email has not been delivered. Required if the `notificationType` is `Bounce`, otherwise not present. |
| `delivery` | [Delivery](#delivery-object) object | Object containing information about the email being delivered to an individual recipient. Required if the `notificationType` is `Delivery`, otherwise not present. |
| `eventId` | String | Unique ID of the event. |

### Mail object {#mail-object}

| Name | Type | Description |
--- | --- | ---
| `timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the email was accepted by {{ postbox-name }}. |
| `messageId` | String | Unique ID of the email. One email can have multiple recipients. Sent by {{ postbox-name }} when accepting the email for processing. |
| `identityId` | String | ID of the {{ postbox-name }} address used when sending the email. |
| `commonHeaders` | [CommonHeaders](#common-headers-object) object | Object containing the main headers of the email. |

### CommonHeaders object {#common-headers-object}

| Name | Type | Description |
--- | --- | ---
| `from` | Array of strings | Contents of the `From` header, broken down by address. |
| `to` | Array of strings | Contents of the `To` header, broken down by address. |
| `subject` | String | `Subject` header contents. |
| `date` | String | `Date` header contents. |
| `messageId` | String | Unique ID of the email. Sent by {{ postbox-name }} when accepting the email. |

### Send object {#send-object}

Empty object.

### Bounce object {#bounce-object}

| Name | Type | Description |
--- | --- | ---
| `bounceType` | String | Error type. The possible values include:<ul><li>`Permenent`: Email not delivered.</li></ul> |
| `bounceSubType` | String | Error subtype. The possible values include:<ul><li>`Undetermined`: Unknown error.</li><li>`Suppressed`: Email not delivered because the recipient is on the stop list.</li></ul> |
| `bouncedRecipients` | Array of [BounceRecipient](#bounce-recipent-object) objects | Array containing information about the email recipient and the related delivery error, if any. |
| `timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the error was received from the recipient's email client. |

### BounceRecipient object {#bounce-recipent-object}

| Name | Type | Description |
--- | --- | ---
| `emailAddress` | String | Recipient's email address. |
| `action` | String | Optional field. Result of sending. Possible values: `failed`. |
| `status` | String | Optional field. SMTP response code. |
| `diagnosticCode` | String | Optional field. Extended error text. May contain error text from the recipient's email client. |

### Delivery object {#delivery-object}

| Name | Type | Description |
--- | --- | ---
| `timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) `(2006-01-02T15:04:05Z07:00)` format. Time when {{ postbox-name }} sent the email and received a successful response from the recipient's email client. |
| `processingTimeMillis` | Integer | Time spent to process the email in milliseconds. |
| `recipients` | Array of strings | Addresses of recipients. |

## Quality of service (QoS) level {#qos}

When delivering notifications, the service supports the `QoS 1: At least once` quality of service level, so it is possible to resend notifications. Identical notifications have the same `eventId`.

If an address is linked to a [configuration](glossary.md#configuration) that has multiple [subscriptions](glossary.md#subscription.md) added to it, a separate notification will come for each assignment.

## Example {#example}

You sent an email to two recipients: `user1@example.com` and `user2@other.example.com`. {{ postbox-name }} sent it to both recipients separately.

The email client of `user1@example.com` accepted the email. The email client of `user2@other.example.com` returned an error after the first attempt to send the email and declined to accept the email after the second attempt, replying that the user was not found.

In which case you will get these three notifications:
* Notification that {{ postbox-name }} accepted the email for processing.
* Notification that the email was delivered to `user1@example.com`.
* Notification that the email was not delivered to `user2@other.example.com` with the error info. The notification will come after the second attempt to send the email.

Since the mail client responded that the recipient `user2@other.example.com` was not found, the address will be temporarily put on the stop list. You should wait for some time before trying to reach the address again, otherwise you will get notified that your message was not delivered because the recipient was on the stop list.
