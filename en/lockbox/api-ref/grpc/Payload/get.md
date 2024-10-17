---
editable: false
sourcePath: en/_api-ref-grpc/lockbox/v1/api-ref/grpc/Payload/get.md
---

# Lockbox API, gRPC: PayloadService.Get {#Get}

Returns the payload of the specified secret.

To get the list of all available secrets, make a [SecretService.List](/docs/lockbox/api-ref/grpc/Secret/list#List) request.

## gRPC request

**rpc Get ([GetPayloadRequest](#yandex.cloud.lockbox.v1.GetPayloadRequest)) returns ([Payload](#yandex.cloud.lockbox.v1.Payload))**

## GetPayloadRequest {#yandex.cloud.lockbox.v1.GetPayloadRequest}

```json
{
  "secretId": "string",
  "versionId": "string"
}
```

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret. ||
|| versionId | **string**

Optional ID of the version. ||
|#

## Payload {#yandex.cloud.lockbox.v1.Payload}

```json
{
  "versionId": "string",
  "entries": [
    {
      "key": "string",
      // Includes only one of the fields `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "bytes"
      // end of the list of possible fields
    }
  ]
}
```

A payload.

#|
||Field | Description ||
|| versionId | **string**

ID of the version that the payload belongs to. ||
|| entries[] | **[Entry](#yandex.cloud.lockbox.v1.Payload.Entry)**

Payload entries. ||
|#

## Entry {#yandex.cloud.lockbox.v1.Payload.Entry}

#|
||Field | Description ||
|| key | **string**

Non-confidential key of the entry. ||
|| textValue | **string**

Text value.

Includes only one of the fields `textValue`, `binaryValue`.

Confidential value of the entry. ||
|| binaryValue | **bytes**

Binary value.

Includes only one of the fields `textValue`, `binaryValue`.

Confidential value of the entry. ||
|#