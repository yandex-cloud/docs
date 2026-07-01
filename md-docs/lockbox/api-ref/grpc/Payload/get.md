# Lockbox API, gRPC: PayloadService.Get

Returns the payload of the specified secret.
To get the list of all available secrets, make a [SecretService.List](../Secret/list.md#List) request.

## gRPC request

**rpc Get ([GetPayloadRequest](#yandex.cloud.lockbox.v1.GetPayloadRequest)) returns ([Payload](#yandex.cloud.lockbox.v1.Payload))**

## GetPayloadRequest {#yandex.cloud.lockbox.v1.GetPayloadRequest}

```json
{
  "secret_id": "string",
  "version_id": "string"
}
```

#|
||Field | Description ||
|| secret_id | **string**

Required field. ID of the secret.

The maximum string length in characters is 50. ||
|| version_id | **string**

Optional ID of the version.

The maximum string length in characters is 50. ||
|#

## Payload {#yandex.cloud.lockbox.v1.Payload}

```json
{
  "version_id": "string",
  "entries": [
    {
      // Includes only one of the fields `text_value`, `binary_value`
      "text_value": "string",
      "binary_value": "bytes",
      // end of the list of possible fields
      "key": "string"
    }
  ]
}
```

A payload.

#|
||Field | Description ||
|| version_id | **string**

ID of the version that the payload belongs to. ||
|| entries[] | **[Entry](#yandex.cloud.lockbox.v1.Payload.Entry)**

Payload entries. ||
|#

## Entry {#yandex.cloud.lockbox.v1.Payload.Entry}

#|
||Field | Description ||
|| text_value | **string**

Text value.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|| binary_value | **bytes**

Binary value.

Includes only one of the fields `text_value`, `binary_value`.

Confidential value of the entry. ||
|| key | **string**

Non-confidential key of the entry. ||
|#