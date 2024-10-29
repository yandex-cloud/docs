---
editable: false
sourcePath: en/_api-ref/speechsense/v1/api-ref/Talk/uploadText.md
---

# Talk Analytics API, REST: Talk.UploadText {#UploadText}

rpc for uploading text talk document

## HTTP request

```
POST https://speechsense.{{ api-host }}/speechsense/v1/talks/uploadText
```

## Body parameters {#yandex.cloud.speechsense.v1.UploadTextRequest}

```json
{
  "metadata": {
    "connectionId": "string",
    "fields": "string",
    "users": [
      {
        "id": "string",
        "role": "string",
        "fields": "string"
      }
    ]
  },
  "textContent": {
    "messages": [
      {
        "userId": "string",
        "timestamp": "string",
        // Includes only one of the fields `text`
        "text": {
          "text": "string"
        }
        // end of the list of possible fields
      }
    ]
  }
}
```

request to create text based dialog

#|
||Field | Description ||
|| metadata | **[TalkMetadata](#yandex.cloud.speechsense.v1.TalkMetadata)** ||
|| textContent | **[TextContent](#yandex.cloud.speechsense.v1.TextContent)** ||
|#

## TalkMetadata {#yandex.cloud.speechsense.v1.TalkMetadata}

#|
||Field | Description ||
|| connectionId | **string**

id of connection this talk belongs too ||
|| fields | **string**

channel defined fields ||
|| users[] | **[UserMetadata](#yandex.cloud.speechsense.v1.UserMetadata)**

per user specific metadata ||
|#

## UserMetadata {#yandex.cloud.speechsense.v1.UserMetadata}

#|
||Field | Description ||
|| id | **string** ||
|| role | **enum** (UserRole)

- `USER_ROLE_UNSPECIFIED`
- `USER_ROLE_OPERATOR`
- `USER_ROLE_CLIENT`
- `USER_ROLE_BOT` ||
|| fields | **string** ||
|#

## TextContent {#yandex.cloud.speechsense.v1.TextContent}

#|
||Field | Description ||
|| messages[] | **[Message](#yandex.cloud.speechsense.v1.Message)** ||
|#

## Message {#yandex.cloud.speechsense.v1.Message}

#|
||Field | Description ||
|| userId | **string** ||
|| timestamp | **string** (date-time)

String in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format. The range of possible values is from
`0001-01-01T00:00:00Z` to `9999-12-31T23:59:59.999999999Z`, i.e. from 0 to 9 digits for fractions of a second.

To work with values in this field, use the APIs described in the
[Protocol Buffers reference](https://developers.google.com/protocol-buffers/docs/reference/overview).
In some languages, built-in datetime utilities do not support nanosecond precision (9 digits). ||
|| text | **[TextPayload](#yandex.cloud.speechsense.v1.TextPayload)**

Includes only one of the fields `text`. ||
|#

## TextPayload {#yandex.cloud.speechsense.v1.TextPayload}

#|
||Field | Description ||
|| text | **string** ||
|#

## Response {#yandex.cloud.speechsense.v1.UploadTextResponse}

**HTTP Code: 200 - OK**

```json
{
  "talkId": "string"
}
```

#|
||Field | Description ||
|| talkId | **string**

id of created talk document ||
|#