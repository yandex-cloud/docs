---
editable: false
---

# Identity Hub API, gRPC: OsLoginService.GetProfile

OsLogin Profiles

## gRPC request

**rpc GetProfile ([GetOsLoginProfileRequest](#yandex.cloud.organizationmanager.v1.GetOsLoginProfileRequest)) returns ([OsLoginProfile](#yandex.cloud.organizationmanager.v1.OsLoginProfile))**

## GetOsLoginProfileRequest {#yandex.cloud.organizationmanager.v1.GetOsLoginProfileRequest}

```json
{
  "os_login_profile_id": "string"
}
```

#|
||Field | Description ||
|| os_login_profile_id | **string**

Required field.

The maximum string length in characters is 50. ||
|#

## OsLoginProfile {#yandex.cloud.organizationmanager.v1.OsLoginProfile}

```json
{
  "id": "string",
  "organization_id": "string",
  "subject_id": "string",
  "login": "string",
  "uid": "int64",
  "is_default": "bool",
  "home_directory": "string",
  "shell": "string"
}
```

#|
||Field | Description ||
|| id | **string** ||
|| organization_id | **string** ||
|| subject_id | **string** ||
|| login | **string** ||
|| uid | **int64** ||
|| is_default | **bool** ||
|| home_directory | **string** ||
|| shell | **string** ||
|#