---
editable: false
sourcePath: en/_api-ref-grpc/iam/v1/api-ref/grpc/Key/get.md
---

# Identity and Access Management API, gRPC: KeyService.Get

Returns the specified Key resource.

To get the list of available Key resources, make a [List](/docs/iam/api-ref/grpc/Key/list#List) request.

## gRPC request

**rpc Get ([GetKeyRequest](#yandex.cloud.iam.v1.GetKeyRequest)) returns ([Key](#yandex.cloud.iam.v1.Key))**

## GetKeyRequest {#yandex.cloud.iam.v1.GetKeyRequest}

```json
{
  "key_id": "string",
  "format": "KeyFormat"
}
```

#|
||Field | Description ||
|| key_id | **string**

Required field. ID of the Key resource to return.
To get the ID use a [KeyService.List](/docs/iam/api-ref/grpc/Key/list#List) request. ||
|| format | enum **KeyFormat**

Output format of the key.

- `PEM_FILE`: Privacy-Enhanced Mail (PEM) format. Default value. ||
|#

## Key {#yandex.cloud.iam.v1.Key}

```json
{
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
}
```

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