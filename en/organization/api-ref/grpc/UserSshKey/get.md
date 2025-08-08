---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/UserSshKey/get.md
---

# Identity Hub API, gRPC: UserSshKeyService.Get

## gRPC request

**rpc Get ([GetUserSshKeyRequest](#yandex.cloud.organizationmanager.v1.GetUserSshKeyRequest)) returns ([UserSshKey](#yandex.cloud.organizationmanager.v1.UserSshKey))**

## GetUserSshKeyRequest {#yandex.cloud.organizationmanager.v1.GetUserSshKeyRequest}

```json
{
  "user_ssh_key_id": "string"
}
```

#|
||Field | Description ||
|| user_ssh_key_id | **string**

Required field.  ||
|#

## UserSshKey {#yandex.cloud.organizationmanager.v1.UserSshKey}

```json
{
  "id": "string",
  "subject_id": "string",
  "data": "string",
  "name": "string",
  "fingerprint": "string",
  "organization_id": "string",
  "created_at": "google.protobuf.Timestamp",
  "expires_at": "google.protobuf.Timestamp"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| subject_id | **string** ||
|| data | **string** ||
|| name | **string** ||
|| fingerprint | **string** ||
|| organization_id | **string** ||
|| created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)** ||
|| expires_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**

Used for temporary keys, if empty the key doesn't expire ||
|#