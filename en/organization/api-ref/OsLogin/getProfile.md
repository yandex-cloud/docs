---
editable: false
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/getProfile.md
---

# Cloud Organization API, REST: OsLogin.GetProfile

OsLogin Profiles

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/osLoginProfiles/{osLoginProfileId}
```

## Path parameters

#|
||Field | Description ||
|| osLoginProfileId | **string**

Required field.  ||
|#

## Response {#yandex.cloud.organizationmanager.v1.OsLoginProfile}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "organizationId": "string",
  "subjectId": "string",
  "login": "string",
  "uid": "string",
  "isDefault": "boolean",
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
|| uid | **string** (int64) ||
|| isDefault | **boolean** ||
|| homeDirectory | **string** ||
|| shell | **string** ||
|#