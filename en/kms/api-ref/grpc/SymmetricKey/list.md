---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricKey/list.md
---

# Key Management Service API, gRPC: SymmetricKeyService.List {#List}

Returns the list of symmetric KMS keys in the specified folder.

## gRPC request

**rpc List ([ListSymmetricKeysRequest](#yandex.cloud.kms.v1.ListSymmetricKeysRequest)) returns ([ListSymmetricKeysResponse](#yandex.cloud.kms.v1.ListSymmetricKeysResponse))**

## ListSymmetricKeysRequest {#yandex.cloud.kms.v1.ListSymmetricKeysRequest}

```json
{
  "folderId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| folderId | **string**

Required field. ID of the folder to list symmetric KMS keys in. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListSymmetricKeysResponse.nextPageToken](#yandex.cloud.kms.v1.ListSymmetricKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListSymmetricKeysResponse.nextPageToken](#yandex.cloud.kms.v1.ListSymmetricKeysResponse) returned by a previous list request. ||
|#

## ListSymmetricKeysResponse {#yandex.cloud.kms.v1.ListSymmetricKeysResponse}

```json
{
  "keys": [
    {
      "id": "string",
      "folderId": "string",
      "createdAt": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "status": "Status",
      "primaryVersion": {
        "id": "string",
        "keyId": "string",
        "status": "Status",
        "algorithm": "SymmetricAlgorithm",
        "createdAt": "google.protobuf.Timestamp",
        "primary": "bool",
        "destroyAt": "google.protobuf.Timestamp",
        "hostedByHsm": "bool"
      },
      "defaultAlgorithm": "SymmetricAlgorithm",
      "rotatedAt": "google.protobuf.Timestamp",
      "rotationPeriod": "google.protobuf.Duration",
      "deletionProtection": "bool"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| keys[] | **[SymmetricKey](#yandex.cloud.kms.v1.SymmetricKey)**

List of symmetric KMS keys in the specified folder. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListSymmetricKeysRequest.pageSize](#yandex.cloud.kms.v1.ListSymmetricKeysRequest), use
the `nextPageToken` as the value for the [ListSymmetricKeysRequest.pageToken](#yandex.cloud.kms.v1.ListSymmetricKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
|#

## SymmetricKey {#yandex.cloud.kms.v1.SymmetricKey}

A symmetric KMS key that may contain several versions of the cryptographic material.

#|
||Field | Description ||
|| id | **string**

ID of the key. ||
|| folderId | **string**

ID of the folder that the key belongs to. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the key was created. ||
|| name | **string**

Name of the key. ||
|| description | **string**

Description of the key. ||
|| labels | **string**

Custom labels for the key as `key:value` pairs. Maximum 64 per key. ||
|| status | enum **Status**

Current status of the key.

- `STATUS_UNSPECIFIED`
- `CREATING`: The key is being created.
- `ACTIVE`: The key is active and can be used for encryption and decryption.
Can be set to INACTIVE using the [SymmetricKeyService.Update](/docs/kms/api-ref/grpc/SymmetricKey/update#Update) method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [SymmetricKeyService.Update](/docs/kms/api-ref/grpc/SymmetricKey/update#Update) method. ||
|| primaryVersion | **[SymmetricKeyVersion](#yandex.cloud.kms.v1.SymmetricKeyVersion)**

Primary version of the key, used as the default for all encrypt/decrypt operations,
when no version ID is specified. ||
|| defaultAlgorithm | enum **SymmetricAlgorithm**

Default encryption algorithm to be used with new versions of the key.

- `SYMMETRIC_ALGORITHM_UNSPECIFIED`
- `AES_128`: AES algorithm with 128-bit keys.
- `AES_192`: AES algorithm with 192-bit keys.
- `AES_256`: AES algorithm with 256-bit keys.
- `AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM ||
|| rotatedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time of the last key rotation (time when the last version was created).
Empty if the key does not have versions yet. ||
|| rotationPeriod | **[google.protobuf.Duration](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/duration)**

Time period between automatic key rotations. ||
|| deletionProtection | **bool**

Flag that inhibits deletion of the key ||
|#

## SymmetricKeyVersion {#yandex.cloud.kms.v1.SymmetricKeyVersion}

Symmetric KMS key version: metadata about actual cryptographic data.

#|
||Field | Description ||
|| id | **string**

ID of the key version. ||
|| keyId | **string**

ID of the symmetric KMS key that the version belongs to. ||
|| status | enum **Status**

Status of the key version.

- `STATUS_UNSPECIFIED`
- `ACTIVE`: The version is active and can be used for encryption and decryption.
- `SCHEDULED_FOR_DESTRUCTION`: The version is scheduled for destruction, the time when it will be destroyed
is specified in the `SymmetricKeyVersion.destroyAt` field.
- `DESTROYED`: The version is destroyed and cannot be recovered. ||
|| algorithm | enum **SymmetricAlgorithm**

Encryption algorithm that should be used when using the key version to encrypt plaintext.

- `SYMMETRIC_ALGORITHM_UNSPECIFIED`
- `AES_128`: AES algorithm with 128-bit keys.
- `AES_192`: AES algorithm with 192-bit keys.
- `AES_256`: AES algorithm with 256-bit keys.
- `AES_256_HSM`: AES algorithm with 256-bit keys hosted by HSM ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the key version was created. ||
|| primary | **bool**

Indication of a primary version, that is to be used by default for all cryptographic
operations that don't have a key version explicitly specified. ||
|| destroyAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Time when the key version is going to be destroyed. Empty unless the status
is `SCHEDULED_FOR_DESTRUCTION`. ||
|| hostedByHsm | **bool**

Indication of the version that is hosted by HSM. ||
|#