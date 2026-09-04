# Email operation notifications

To receive email operation notifications, [create a configuration](../operations/create-configuration.md) and [associate it with your address](../operations/bind-configuration.md).

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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
               "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "send": {  },
    "eventId": "vgAyRUls8591ybPKeH-Ov:0"
}
```

### Email rendering error notification {#rendering-failure}

It appears if {{ postbox-name }} accepted the email for processing, but there was an error rendering the template.

Notification example:

```json
{
    "eventType": "Rendering Failure",
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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
               "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "failure": {
        "errorMessage": "template variable not_var{{name}} is missing"
    },
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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
               "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "ses:outgoing-tls-cipher": [
                "AES_128_GCM_SHA256"
            ],
            "ses:outgoing-tls-version": [
                "TLSv1.3"
            ],
            "ses:outgoing-ip": [
                "51.250.56.125"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
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

Comes when the recipient's mail exchange server responds to a delivery attempt with an error which, according to {{ postbox-name }}, does not require another delivery attempt, or when the recipient's address is on the suppression list.

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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
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
        "dialAttempts": [
            {
                "mxHost": "mx.example.com.",
                "ip": "192.0.2.1",
                "reason": "Smtp",
                "error": "read response error: 554 5.7.1 Message rejected under suspicion of SPAM",
                "negotiatedTls": "TLSv1.3"
            }
        ]
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Email open notification {#open}

Comes when the recipient opens the email.

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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
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

### Email click notification {#click}

Comes when the recipient clicks a link in the email.

Notification example:

```json
{
    "eventType": "Click",
    "mail": {
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "messageId": "QA_JPkU2fkpIWdkxAOASH",
        "identityId": "ZtYk0rrjN87m-Ovxjte1G",
        "commonHeaders": {
            "from":[ "User <user@example.com>" ],
            "date":"Thu, 27 Jun 2024 14:05:45 +0000",
            "to":[ "Recipient Name <recipient@example.com>" ],
            "messageId":"QA_JPkU2fkpIWdkxAOASH",
            "subject":"Message sent using {{ postbox-full-name }}"
        },
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "click": {
        "ipAddress": "192.0.2.1",
        "timestamp": "2024-04-25T18:08:04.933666+03:00",
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60",
        "url": "https://example.com/some-link",
        "linkTags": {
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Delayed email delivery notification {#delayed-delivery}

Once successfully accepted by {{ postbox-name }}, the email is normally sent right away. However, a slight delay in delivery may sometimes occur. It is in this case that you receive this type of notification.

The system triggers this notification exactly once following the first failed delivery attempt. If the email remains undelivered, you will receive a [delivery failure notification](#bounce).

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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "deliveryDelay": {
        "delayType": "General",
        "delayedRecipients": [
            {
                "emailAddress": "recipient@example.com",
                "status": "4.4.1",
                "diagnosticCode": "421 4.4.1 Connection timed out"
            }
        ],
        "reportingMTA": "mx.example.com",
        "timestamp": "2024-04-25T18:10:04.973666+03:00"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Recipient unsubscribe notification {#subscription}

Comes when the recipient uses the `one-click unsubscribe` mechanism added by {{ postbox-name }} into the email.

Notification example:

```json
{
    "eventType": "Subscription",
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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "subscription": {
        "contactList": "my-list",
        "timestamp": "2024-04-25T18:08:04.973666+03:00",
        "source": "UnsubscribeHeader"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

### Email complaint notification {#complaint}

Comes when the recipient complains about an incoming email, and the Internet Service Provider (ISP) forwards the complaint to {{ postbox-name }}.

Notification example:

```json
{
    "eventType": "Complaint",
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
        "headers": [
            { "name": "From", "value": "User <user@example.com>" },
            { "name": "To", "value": "Recipient Name <recipient@example.com>" },
            { "name": "Subject", "value": "Message sent using Yandex Cloud Postbox" },
            { "name": "Date", "value": "Thu, 27 Jun 2024 14:05:45 +0000" },
            { "name": "Content-Type", "value": "text/plain; charset=UTF-8" },
            { "name": "X-Campaign-Id", "value": "summer-sale-2024" }
        ],
        "tags": {
            "ses:configuration-set": [
                "kXVCt2Vd4dvm3MDvpc5Ml"
            ],
            "ses:from-domain": [
                "example.com"
            ],
            "ses:source-ip": [
                "123.123.123.123"
            ],
            "key1": [
                "value1"
            ],
            "key2": [
                "value2"
            ]
        }
    },
    "complaint": {
        "complainedRecipients": [
            {
                "emailAddress": "recipient@example.com"
            }
        ],
        "complaintFeedbackType": "abuse",
        "arrivalDate": "2024-04-25T18:05:04.84108+03:00",
        "timestamp": "2024-04-25T18:10:04.973666+03:00",
        "userAgent": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_3 like Mac OS X) AppleWebKit/603.3.8 (KHTML, like Gecko) Mobile/14G60"
    },
    "eventId": "jdMtnVniDeHqlQX8ygwEX:0"
}
```

## Notification format {#format}

The notification is written to the {{ yds-full-name }} [data stream](../../data-streams/concepts/glossary.md#stream-concepts) in JSON format. The list and sequence of fields may differ from those described below.

### Main object {#main-object}

Name | Type | Description
--- | --- | ---
`eventType` | String | [Notification type](#types). The possible values are `Bounce`, `Click`, `Complaint`, `Delivery`, `DeliveryDelay`, `Open`, `Rendering Failure`, `Send`, and `Subscription`.
`mail` | [Mail](#mail-object) object | Object containing general information about the sent email.
`send` | [Send](#send-object) object | Empty object. Required if the `eventType` is `Send`; otherwise, not present.
`bounce` | [Bounce](#bounce-object) object | Object containing information that the email has not been delivered. Required if the `eventType` is `Bounce`; otherwise, not present.
`delivery` | [Delivery](#delivery-object) object | Object containing information about the email being delivered to an individual recipient. Required if the `eventType` is `Delivery`; otherwise, not present.
`complaint` | [Complaint](#complaint-object) object | Object containing information about the recipient's complaint about an email. Required if the `eventType` is `Complaint`; otherwise, not present.
`subscription` | [Subscription](#subscription-object) object | Object containing information that the recipient has unsubscribed from the mailing list. Required if the `eventType` is `Subscription`; otherwise, not present.
`deliveryDelay` | [DeliveryDelay](#delivery-delay-object) object | Object containing information about the email delivery delay. Required if the `eventType` is `DeliveryDelay`; otherwise, not present.
`open` | [Open](#open-object) object | Object containing information that the email has been opened. Required if the `eventType` is `Open`; otherwise, not present.
`click` | [Click](#click-object) object | Object containing information about following a clickable link in the email. Required if the `eventType` is `Click`; otherwise, not present.
`failure` | [Failure](#failure-object) object | Object containing information about the email rendering error. Required if the `eventType` is `Rendering Failure`; otherwise, not present.
`eventId` | String | Unique ID of the event.

### Mail object {#mail-object}

Name | Type | Description
--- | --- | ---
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the email was accepted by {{ postbox-name }}.
`messageId` | String | Unique ID of the email. One email can have multiple recipients. Sent by {{ postbox-name }} when accepting the email for processing.
`identityId` | String | ID of the {{ postbox-name }} address used when sending the email.
`commonHeaders` | [CommonHeaders](#common-headers-object) object | Object containing the main headers of the email.
`headers` | Array of [Header](#header-object) objects | Full list of email headers as received by {{ postbox-name }} before adding system-generated service headers. This list includes custom headers added by the sender, e.g., `X-Campaign-Id`. This field is omitted if message headers are not retained.
`headersTruncated` | Boolean | The field is present only if its value is `true`. A value of `true` indicates the `headers` list is incomplete and has been cut off from the end because the total size of headers exceeded the 10 KiB limit.
`tags` | Object | Object containing tags added to the email. The value of each tag is an array of strings. Custom tags always contain only one item.

{% note info %}

The `headers` array contains message headers exactly as transmitted by the sender, including custom headers, e.g., `X-Campaign-Id`. Headers that {{ postbox-name }} adds or modifies when processing an email, such as `List-Unsubscribe`, `List-Unsubscribe-Post`, or `DKIM-Signature`, are excluded from `headers`. The order of the headers is preserved.

{% endnote %}

{% note info %}

While `headers` contains the original email headers, `commonHeaders` includes the final headers generated after {{ postbox-name }} has processed the email. Thus, `commonHeaders.messageId` indicates the ID issued by {{ postbox-name }}, while `headers` may contain the sender's own `Message-Id` header.

Notifications preserve header values exactly as they appeared within the email  If a header is encoded under [RFC 2047](https://www.ietf.org/rfc/rfc2047.txt), e.g., Cyrillic script is used in the email subject or sender's display name, the notification will display that encoded value. Decoding must be provisioned on the notification recipient side. This applies to all items within `headers`, as well as the `commonHeaders.from`, `commonHeaders.to`, and `commonHeaders.subject` fields.

{% endnote %}

### CommonHeaders object {#common-headers-object}

Name | Type | Description
--- | --- | ---
`from` | Array of strings | Contents of the `From` header, broken down by address. Remains empty if the email has no header. If parsing addresses from the value fails, the array contains a single item, which is the entire original header string.
`to` | Array of strings | Contents of the `To` header, broken down by address. Remains empty if the email has no header. If parsing addresses from the value fails, the array contains a single item, which is the entire original header string.
`subject` | String | Contents of the `Subject` header. Remains empty if the email has no header.
`date` | String | Contents of the `Date` header. Remains empty if the email has no header.
`messageId` | String | Unique ID of the email. Sent by {{ postbox-name }} when accepting the email.
`originalMessageId` | String | Contains the value of the `Original-Message-ID` header if provided by the sender. Otherwise, returns an empty string.

### Header object {#header-object}

Name | Type | Description
--- | --- | ---
`name` | String | Email header name
`value` | String | Email header value

### Send object {#send-object}

Empty object.

### Bounce object {#bounce-object}

Name | Type | Description
--- | --- | ---
`bounceType` | String | Error type. The possible values are:<ul><li>`Permanent`: Email not delivered.</li></ul>
`bounceSubType` | String | Error subtype. The possible values are:<ul><li>`Undetermined`: Error cause not determined.</li><li>`Suppressed`: Email not delivered because the recipient is on the {{ postbox-name }} global suppression list.</li><li>`OnAccountSuppressionList`: Email not delivered because the recipient is on the {{ postbox-name }} user's suppression list.</li><li>`InsufficientTLS`: Failed to establish a secure TLS connection with the recipient's server.</li><li>`StartTlsNotOffered`: Recipient's server does not support the `STARTTLS` command.</li><li>`TlsCertificateUntrusted`: Recipient's server failed to present a trusted certificate.</li><li>`TlsVersionTooLow`: TLS version supported by the recipient's server is below the minimum acceptable value.</li></ul>
`bouncedRecipients` | Array of [BounceRecipient](#bounce-recipent-object) objects | Array containing information about the email recipient and the related delivery error, if any.
`dialAttempts` | Array of [DialAttempt](#dial-attempt-object) objects | This is an optional field. A list of connection attempts to the recipient's mail servers and their specific error details. Omitted if no connection was made, e.g., if the address is on a suppression list.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the error was received from the recipient's email client.

### BounceRecipient object {#bounce-recipent-object}

Name | Type | Description
--- | --- | ---
`emailAddress` | String | Recipient's email address.
`action` | String | This is an optional field. Result of sending. The possible value is `failed`.
`status` | String | Optional field. SMTP response code.
`diagnosticCode` | String | This is an optional field. Extended error text. For errors received from the recipient’s server, contains the response payload returned by that server. Otherwise, takes one of the following values: `Host or MX not found`, `Too many attempts`, `Spam detected`, `Insufficient TLS`, `STARTTLS not offered by recipient MX`, `TLS certificate not trusted`, `TLS version too low`, `Blocked by Global Suppression List`, `Blocked by Account Suppression List`, `Other`, or `Unknown`.

### DialAttempt object {#dial-attempt-object}

Name | Type | Description
--- | --- | ---
`mxHost` | String | Name of the recipient's mail exchange server (MX host) targeted by the connection. This value is provided as a fully qualified domain name (FQDN) and may include a trailing dot.
`ip` | String | Connection's target IP address
`reason` | String | Code for the error root cause. The possible values are `Smtp`, `HostOrMXNotFound`, `Spam`, `TooManyAttempts`, `InsufficientTLS`, `StartTlsNotOffered`, `TlsCertUntrusted`, `TlsVersionTooLow`, and `Other`.
`error` | String | Error message for this connection attempt. These messages do not have a unified format and may vary, so use the`reason` property instead for programmatic processing.
`negotiatedTls` | String | This is an optional field. The TLS version negotiated with the recipient's server, e.g., `TLSv1.2`. Omitted if no TLS connection has been established.

### Click object {#click-object}

Name | Type | Description
--- | --- | ---
`ipAddress` | String | IP address of the recipient’s device used to open the link.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time when the recipient clicked the link.
`userAgent` | String | Identification string (`User-Agent`) of the device or email the client used to open the link.
`url` | String | Original URL the recipient opened.
`linkTags` | Object | Object containing tags added to the link.

### Complaint object {#complaint-object}

Name | Type | Description
--- | --- | ---
`complainedRecipients` | [ComplainedRecipient](#complained-recipient-object) object array | Array containing information about the recipients who might have filed the complaint.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the ISP sent the complaint to {{ postbox-name }}.
`complaintFeedbackType` | String | This is an optional field. Complaint type from the ISP's report. The possible values are:<ul><li>`abuse`: Unsolicited mail or other misuse.</li><li>`auth-failure`: Email authentication error.</li><li>`fraud`: Phishing or fraud.</li><li>`not-spam`: Recipient does not think the email is spam (used to correct a false positive).</li><li>`other`: Complaint not falling under any other types.</li><li>`virus`: Virus detected in the email.</li></ul>
`arrivalDate` | String | This is an optional field. Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Time the original email arrived at the recipient’s server.
`userAgent` | String | This is an optional field. The `User-Agent` field value from the complaint report, i.e., the name and version of the system that generated the report.

### ComplainedRecipient object {#complained-recipient-object}

Name | Type | Description
--- | --- | ---
`emailAddress` | String | Email address of the recipient who might have filed the complaint.

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
`reportingMTA` | String | Name of the recipient's mail exchange server that reported the delivery delay. May return an empty string if the server could not be identified.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Delivery delay timestamp.

### DelayedRecipient object {#delayed-recipient-object}

Name | Type | Description
--- | --- | ---
`emailAddress` | String | Recipient's email address.
`status` | String | SMTP response code from the recipient's server. May return an empty string.
`diagnosticCode` | String | This is an optional field. Extended error text. May contain the recipient's server response payload.

### Failure object {#failure-object}

Name | Type | Description
--- | --- | ---
`errorMessage` | String | Rendering error description.
`templateName` | String | This is an optional field. The name of the template that threw an error when rendered, if sent in the notification.

### Subscription object {#subscription-object}

Name | Type | Description
--- | --- | ---
`contactList` | String | Name of the contact list associated with the email.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Recipient unsubscribe timestamp.
`source` | String | Unsubscribe source. The possible value is `UnsubscribeHeader`.

### Open object {#open-object}

Name | Type | Description
--- | --- | ---
`ipAddress` | String | IP address of the recipient’s device used to open the email.
`timestamp` | String | Date in [RFC 3339](https://www.ietf.org/rfc/rfc3339.txt) (`2006-01-02T15:04:05Z07:00`) format. Email opening timestamp.
`userAgent` | String | Identification string (`User-Agent`) of the device or email the client used to open the email.

## System tags {#system-tags}

When sending an email, {{ postbox-name }} adds the following system tags to it and then includes them in notifications.

Common tags:

Name | Description
--- | ---
`ses:configuration-set` | ID of the [configuration](glossary.md#configuration) used when sending the email.
`ses:from-domain` | Domain the email was sent from.
`ses:source-ip` | IP address of the server the email to {{ postbox-name }} was sent from by the user.

Additional tags included only into [delivery notifications](#delivery):

Name | Description
--- | ---
`ses:outgoing-tls-version` | TLS version used to send the email to the recipient server.
`ses:outgoing-tls-cipher` | TLS cipher used to send the email to the recipient server.
`ses:outgoing-ip` | IP address of the server from which the email was sent by {{ postbox-name }} to the recipient server.

## Quality of service (QoS) level {#qos}

To deliver notifications, the service supports the `QoS 1: At least once` quality of service level, so it is possible to resend notifications. Identical notifications have the same `eventId`.

If an address is linked to a [configuration](glossary.md#configuration) that has multiple [subscriptions](glossary.md#subscription) added to it, a separate notification will come for each assignment.

## Use case {#example}

You sent an email to two recipients: `user1@example.com` and `user2@other.example.com`. {{ postbox-name }} sent it to both recipients separately.

The email client of `user1@example.com` accepted the email. The email client of the recipient `user2@other.example.com` returned an error after the first attempt to send the email and declined to accept the email after the second attempt, replying that the user was not found.

In which case you will get these three notifications:

* Notification that {{ postbox-name }} accepted the email for processing.
* Notification that the email was delivered to `user1@example.com`.
* Notification that the email was not delivered to `user2@other.example.com` with the error info. The notification will come after the second attempt to send the email.

Since the mail client responded that the recipient `user2@other.example.com` was not found, the address will be temporarily put on the stop list. You should wait for some time before trying to reach the address again, otherwise you will get notified that your message was not delivered because the recipient was on the stop list.
