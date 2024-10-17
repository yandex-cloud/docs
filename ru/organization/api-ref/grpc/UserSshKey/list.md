---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/UserSshKey/list.md
---

# Cloud Organization API, gRPC: UserSshKeyService.List {#List}

## gRPC request

**rpc List ([ListUserSshKeysRequest](#yandex.cloud.organizationmanager.v1.ListUserSshKeysRequest)) returns ([ListUserSshKeysResponse](#yandex.cloud.organizationmanager.v1.ListUserSshKeysResponse))**

## ListUserSshKeysRequest {#yandex.cloud.organizationmanager.v1.ListUserSshKeysRequest}

```json
{
  "organizationId": "string",
  "subjectId": "string",
  "pageSize": "int64",
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|| subjectId | **string**

if empty, list all organization keys ||
|| pageSize | **int64** ||
|| pageToken | **string** ||
|#

## ListUserSshKeysResponse {#yandex.cloud.organizationmanager.v1.ListUserSshKeysResponse}

```json
{
  "sshKeys": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| sshKeys[] | **[UserSshKey](#yandex.cloud.organizationmanager.v1.UserSshKey)** ||
|| nextPageToken | **string** ||
|#

## UserSshKey {#yandex.cloud.organizationmanager.v1.UserSshKey}

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