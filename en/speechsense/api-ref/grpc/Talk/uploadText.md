---
editable: false
sourcePath: en/_api-ref-grpc/speechsense/v1/api-ref/grpc/Talk/uploadText.md
---

# Talk Analytics API, gRPC: TalkService.UploadText {#UploadText}

rpc for uploading text talk document

## gRPC request

**rpc UploadText ([UploadTextRequest](#yandex.cloud.speechsense.v1.UploadTextRequest)) returns ([UploadTextResponse](#yandex.cloud.speechsense.v1.UploadTextResponse))**

## UploadTextRequest {#yandex.cloud.speechsense.v1.UploadTextRequest}

```json
{
  "metadata": {
    "connectionId": "string",
    "fields": "string",
    "users": [
      {
        "id": "string",
        "role": "UserRole",
        "fields": "string"
      }
    ]
  },
  "textContent": {
    "messages": [
      {
        "userId": "string",
        "timestamp": "google.protobuf.Timestamp",
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
|| role | enum **UserRole**

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
|| timestamp | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| text | **[TextPayload](#yandex.cloud.speechsense.v1.TextPayload)**

Includes only one of the fields `text`. ||
|#

## TextPayload {#yandex.cloud.speechsense.v1.TextPayload}

#|
||Field | Description ||
|| text | **string** ||
|#

## UploadTextResponse {#yandex.cloud.speechsense.v1.UploadTextResponse}

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