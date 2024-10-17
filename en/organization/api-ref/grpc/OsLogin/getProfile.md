---
editable: false
sourcePath: en/_api-ref-grpc/organizationmanager/v1/api-ref/grpc/OsLogin/getProfile.md
---

# Cloud Organization API, gRPC: OsLoginService.GetProfile {#GetProfile}

OsLogin Profiles

## gRPC request

**rpc GetProfile ([GetOsLoginProfileRequest](#yandex.cloud.organizationmanager.v1.GetOsLoginProfileRequest)) returns ([OsLoginProfile](#yandex.cloud.organizationmanager.v1.OsLoginProfile))**

## GetOsLoginProfileRequest {#yandex.cloud.organizationmanager.v1.GetOsLoginProfileRequest}

```json
{
  "osLoginProfileId": "string"
}
```

#|
||Field | Description ||
|| osLoginProfileId | **string**

Required field.  ||
|#

## OsLoginProfile {#yandex.cloud.organizationmanager.v1.OsLoginProfile}

```json
{
  "id": "string",
  "organizationId": "string",
  "subjectId": "string",
  "login": "string",
  "uid": "int64",
  "isDefault": "bool",
  "homeDirectory": "string",
  "shell": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| organizationId | **string** ||
|| subjectId | **string** ||
|| login | **string** ||
|| uid | **int64** ||
|| isDefault | **bool** ||
|| homeDirectory | **string** ||
|| shell | **string** ||
|#