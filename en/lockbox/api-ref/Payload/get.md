---
editable: false
sourcePath: en/_api-ref/lockbox/v1/api-ref/Payload/get.md
---

# Lockbox API, REST: Payload.Get

Returns the payload of the specified secret.

To get the list of all available secrets, make a [SecretService.List](/docs/lockbox/api-ref/Secret/list#List) request.

## HTTP request

```
GET https://{{ api-host-lockbox-payload }}/lockbox/v1/secrets/{secretId}/payload
```

## Path parameters

#|
||Field | Description ||
|| secretId | **string**

Required field. ID of the secret. ||
|#

## Query parameters {#yandex.cloud.lockbox.v1.GetPayloadRequest}

#|
||Field | Description ||
|| versionId | **string**

Optional ID of the version. ||
|#

## Response {#yandex.cloud.lockbox.v1.Payload}

**HTTP Code: 200 - OK**

```json
{
  "versionId": "string",
  "entries": [
    {
      "key": "string",
      // Includes only one of the fields `textValue`, `binaryValue`
      "textValue": "string",
      "binaryValue": "string"
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
|| binaryValue | **string** (bytes)

Binary value.

Includes only one of the fields `textValue`, `binaryValue`.

Confidential value of the entry. ||
|#