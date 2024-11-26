---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/Key/create.md
---

# Identity and Access Management API, gRPC: KeyService.Create

Creates a key pair for the specified service account.

## gRPC request

**rpc Create ([CreateKeyRequest](#yandex.cloud.iam.v1.CreateKeyRequest)) returns ([CreateKeyResponse](#yandex.cloud.iam.v1.CreateKeyResponse))**

## CreateKeyRequest {#yandex.cloud.iam.v1.CreateKeyRequest}

```json
{
  "service_account_id": "string",
  "description": "string",
  "format": "KeyFormat",
  "key_algorithm": "Algorithm"
}
```

#|
||Field | Description ||
|| service_account_id | **string**

ID of the service account to create a key pair for.
To get the service account ID, use a [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/ServiceAccount/list#List) request.
If not specified, it defaults to the subject that made the request. ||
|| description | **string**

Description of the key pair. ||
|| format | enum **KeyFormat**

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|| key_algorithm | enum **Algorithm**

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
    // Includes only one of the fields `user_account_id`, `service_account_id`
    "user_account_id": "string",
    "service_account_id": "string",
    // end of the list of possible fields
    "created_at": "google.protobuf.Timestamp",
    "description": "string",
    "key_algorithm": "Algorithm",
    "public_key": "string",
    "last_used_at": "google.protobuf.Timestamp"
  },
  "private_key": "string"
}
```

#|
||Field | Description ||
|| key | **[Key](#yandex.cloud.iam.v1.Key)**

Key resource. ||
|| private_key | **string**

A private key of the Key resource.
This key must be stored securely. ||
|#

## Key {#yandex.cloud.iam.v1.Key}

A Key resource. For more information, see [Authorized keys](/docs/iam/concepts/authorization/key).

#|
||Field | Description ||
|| id | **string**

ID of the Key resource. ||
|| user_account_id | **string**

ID of the user account that the Key resource belongs to.

Includes only one of the fields `user_account_id`, `service_account_id`. ||
|| service_account_id | **string**

ID of the service account that the Key resource belongs to.

Includes only one of the fields `user_account_id`, `service_account_id`. ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Creation timestamp. ||
|| description | **string**

Description of the Key resource. 0-256 characters long. ||
|| key_algorithm | enum **Algorithm**

An algorithm used to generate a key pair of the Key resource.

- `ALGORITHM_UNSPECIFIED`
- `RSA_2048`: RSA with a 2048-bit key size. Default value.
- `RSA_4096`: RSA with a 4096-bit key size. ||
|| public_key | **string**

A public key of the Key resource. ||
|| last_used_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Timestamp for the last use of this key. ||
|#