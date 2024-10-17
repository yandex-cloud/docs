---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/UserSshKey/get.md
---

# Cloud Organization API, gRPC: UserSshKeyService.Get {#Get}

## gRPC request

**rpc Get ([GetUserSshKeyRequest](#yandex.cloud.organizationmanager.v1.GetUserSshKeyRequest)) returns ([UserSshKey](#yandex.cloud.organizationmanager.v1.UserSshKey))**

## GetUserSshKeyRequest {#yandex.cloud.organizationmanager.v1.GetUserSshKeyRequest}

```json
{
  "userSshKeyId": "string"
}
```

#|
||Field | Description ||
|| userSshKeyId | **string**

Required field.  ||
|#

## UserSshKey {#yandex.cloud.organizationmanager.v1.UserSshKey}

```json
{
  "id": "string",
  "subjectId": "string",
  "data": "string",
  "name": "string",
  "fingerprint": "string",
  "organizationId": "string",
  "createdAt": "google.protobuf.Timestamp",
  "expiresAt": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| subjectId | **string** ||
|| data | **string** ||
|| name | **string** ||
|| fingerprint | **string** ||
|| organizationId | **string** ||
|| createdAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| expiresAt | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Used for temporary keys, if empty the key doesn't expire ||
|#