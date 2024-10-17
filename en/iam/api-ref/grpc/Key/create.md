---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/Key/create.md
---

# Identity and Access Management API, gRPC: KeyService.Create {#Create}

Creates a key pair for the specified service account.

## gRPC request

**rpc Create ([CreateKeyRequest](#yandex.cloud.iam.v1.CreateKeyRequest)) returns ([CreateKeyResponse](#yandex.cloud.iam.v1.CreateKeyResponse))**

## CreateKeyRequest {#yandex.cloud.iam.v1.CreateKeyRequest}

```json
{
  "serviceAccountId": "string",
  "description": "string",
  "format": "KeyFormat",
  "keyAlgorithm": "Algorithm"
}
```

#|
||Field | Description ||
|| serviceAccountId | **string**

ID of the service account to create a key pair for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| description | **string**

Description of the key pair. ||
|| format | enum **KeyFormat**

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|| keyAlgorithm | enum **Algorithm**

An algorithm used to generate a key pair of the Key resource.

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048`: RSA with a 2048-bit key size. Default value.
- `RSA_4096`: RSA with a 4096-bit key size. ||
|#

## CreateKeyResponse {#yandex.cloud.iam.v1.CreateKeyResponse}

```json
{
  "key": {
    "id": "string",
    // Includes only one of the fields `userAccountId`, `serviceAccountId`
    "userAccountId": "string",
    "serviceAccountId": "string",
    // end of the list of possible fields
    "createdAt": "google.protobuf.Timestamp",
    "description": "string",
    "keyAlgorithm": "Algorithm",
    "publicKey": "string",
    "lastUsedAt": "google.protobuf.Timestamp"
  },
  "privateKey": "string"
}
```

#|
||Field | Description ||
|| key | **[Key](#yandex.cloud.iam.v1.Key)**

Key resource. ||
|| privateKey | **string**

A private key of the Key resource.
This key must be stored securely. ||
|#

## Key {#yandex.cloud.iam.v1.Key}

A Key resource. For more information, see [Authorized keys](/docs/iam/concepts/authorization/key).

#|
||Field | Description ||
|| id | **string**

ID of the Key resource. ||
|| userAccountId | **string**

ID of the user account that the Key resource belongs to.

Includes only one of the fields `userAccountId`, `serviceAccountId`. ||
|| serviceAccountId | **string**

ID of the service account that the Key resource belongs to.

Includes only one of the fields `userAccountId`, `serviceAccountId`. ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the Key resource. 0-256 characters long. ||
|| keyAlgorithm | enum **Algorithm**

An algorithm used to generate a key pair of the Key resource.

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048`: RSA with a 2048-bit key size. Default value.
- `RSA_4096`: RSA with a 4096-bit key size. ||
|| publicKey | **string**

A public key of the Key resource. ||
|| lastUsedAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last use of this key. ||
|#