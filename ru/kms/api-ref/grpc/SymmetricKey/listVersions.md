---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/api-ref/grpc/SymmetricKey/listVersions.md
---

# Key Management Service API, gRPC: SymmetricKeyService.ListVersions {#ListVersions}

Returns the list of versions of the specified symmetric KMS key.

## gRPC request

**rpc ListVersions ([ListSymmetricKeyVersionsRequest](#yandex.cloud.kms.v1.ListSymmetricKeyVersionsRequest)) returns ([ListSymmetricKeyVersionsResponse](#yandex.cloud.kms.v1.ListSymmetricKeyVersionsResponse))**

## ListSymmetricKeyVersionsRequest {#yandex.cloud.kms.v1.ListSymmetricKeyVersionsRequest}

```json
{
  "keyId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| keyId | **string**

Required field. ID of the symmetric KMS key to list versions for. ||
|| pageSize | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`, the service returns a [ListSymmetricKeyVersionsResponse.nextPageToken](#yandex.cloud.kms.v1.ListSymmetricKeyVersionsResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListSymmetricKeyVersionsResponse.nextPageToken](#yandex.cloud.kms.v1.ListSymmetricKeyVersionsResponse) returned by a previous list request. ||
|#

## ListSymmetricKeyVersionsResponse {#yandex.cloud.kms.v1.ListSymmetricKeyVersionsResponse}

```json
{
  "keyVersions": [
    {
      "id": "string",
      "keyId": "string",
      "status": "Status",
      "algorithm": "SymmetricAlgorithm",
      "createdAt": "google.protobuf.Timestamp",
      "primary": "bool",
      "destroyAt": "google.protobuf.Timestamp",
      "hostedByHsm": "bool"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| keyVersions[] | **[SymmetricKeyVersion](#yandex.cloud.kms.v1.SymmetricKeyVersion)**

List of versions for the specified symmetric KMS key. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListSymmetricKeyVersionsRequest.pageSize](#yandex.cloud.kms.v1.ListSymmetricKeyVersionsRequest), use
the `nextPageToken` as the value for the [ListSymmetricKeyVersionsRequest.pageToken](#yandex.cloud.kms.v1.ListSymmetricKeyVersionsRequest) query parameter
in the next list request. Each subsequent list request will have its own
`nextPageToken` to continue paging through the results. ||
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