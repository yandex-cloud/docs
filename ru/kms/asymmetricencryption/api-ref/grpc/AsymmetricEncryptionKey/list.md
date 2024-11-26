---
editable: false
sourcePath: en/_api-ref-grpc/kms/v1/asymmetricencryption/api-ref/grpc/AsymmetricEncryptionKey/list.md
---

# Key Management Service API, gRPC: AsymmetricEncryptionKeyService.List

Returns the list of asymmetric KMS keys in the specified folder.

## gRPC request

**rpc List ([ListAsymmetricEncryptionKeysRequest](#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysRequest)) returns ([ListAsymmetricEncryptionKeysResponse](#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysResponse))**

## ListAsymmetricEncryptionKeysRequest {#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysRequest}

```json
{
  "folder_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| folder_id | **string**

Required field. ID of the folder to list asymmetric KMS keys in. ||
|| page_size | **int64**

The maximum number of results per page to return. If the number of available
results is larger than `page_size`, the service returns a [ListAsymmetricEncryptionKeysResponse.next_page_token](#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysResponse)
that can be used to get the next page of results in subsequent list requests.
Default value: 100. ||
|| page_token | **string**

Page token. To get the next page of results, set `page_token` to the
[ListAsymmetricEncryptionKeysResponse.next_page_token](#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysResponse) returned by a previous list request. ||
|#

## ListAsymmetricEncryptionKeysResponse {#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysResponse}

```json
{
  "keys": [
    {
      "id": "string",
      "folder_id": "string",
      "created_at": "google.protobuf.Timestamp",
      "name": "string",
      "description": "string",
      "labels": "string",
      "status": "Status",
      "encryption_algorithm": "AsymmetricEncryptionAlgorithm",
      "deletion_protection": "bool"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| keys[] | **[AsymmetricEncryptionKey](#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricEncryptionKey)**

List of asymmetric KMS keys in the specified folder. ||
|| next_page_token | **string**

This token allows you to get the next page of results for list requests. If the number
of results is greater than the specified [ListAsymmetricEncryptionKeysRequest.page_size](#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysRequest), use
the `next_page_token` as the value for the [ListAsymmetricEncryptionKeysRequest.page_token](#yandex.cloud.kms.v1.asymmetricencryption.ListAsymmetricEncryptionKeysRequest) query parameter
in the next list request. Each subsequent list request will have its own
`next_page_token` to continue paging through the results. ||
|#

## AsymmetricEncryptionKey {#yandex.cloud.kms.v1.asymmetricencryption.AsymmetricEncryptionKey}

An asymmetric KMS key that may contain several versions of the cryptographic material.

#|
||Field | Description ||
|| id | **string**

ID of the key. ||
|| folder_id | **string**

ID of the folder that the key belongs to. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

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
- `ACTIVE`: The key is active and can be used for encryption and decryption or signature and verification.
Can be set to INACTIVE using the [AsymmetricKeyService.Update] method.
- `INACTIVE`: The key is inactive and unusable.
Can be set to ACTIVE using the [AsymmetricKeyService.Update] method. ||
|| encryption_algorithm | enum **AsymmetricEncryptionAlgorithm**

Asymmetric Encryption Algorithm ID.

- `ASYMMETRIC_ENCRYPTION_ALGORITHM_UNSPECIFIED`
- `RSA_2048_ENC_OAEP_SHA_256`: RSA-2048 encryption with OAEP padding and SHA-256
- `RSA_3072_ENC_OAEP_SHA_256`: RSA-3072 encryption with OAEP padding and SHA-256
- `RSA_4096_ENC_OAEP_SHA_256`: RSA-4096 encryption with OAEP padding and SHA-256 ||
|| deletion_protection | **bool**

Flag that inhibits deletion of the key ||
|#