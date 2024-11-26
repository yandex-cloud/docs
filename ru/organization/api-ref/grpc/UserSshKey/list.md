---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/UserSshKey/list.md
---

# Cloud Organization API, gRPC: UserSshKeyService.List

## gRPC request

**rpc List ([ListUserSshKeysRequest](#yandex.cloud.organizationmanager.v1.ListUserSshKeysRequest)) returns ([ListUserSshKeysResponse](#yandex.cloud.organizationmanager.v1.ListUserSshKeysResponse))**

## ListUserSshKeysRequest {#yandex.cloud.organizationmanager.v1.ListUserSshKeysRequest}

```json
{
  "organization_id": "string",
  "subject_id": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| organization_id | **string**

Required field.  ||
|| subject_id | **string**

if empty, list all organization keys ||
|| page_size | **int64** ||
|| page_token | **string** ||
|#

## ListUserSshKeysResponse {#yandex.cloud.organizationmanager.v1.ListUserSshKeysResponse}

```json
{
  "ssh_keys": [
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
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| ssh_keys[] | **[UserSshKey](#yandex.cloud.organizationmanager.v1.UserSshKey)** ||
|| next_page_token | **string** ||
|#

## UserSshKey {#yandex.cloud.organizationmanager.v1.UserSshKey}

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