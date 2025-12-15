---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/osLoginProfiles/{osLoginProfileId}
    method: get
    path:
      type: object
      properties:
        osLoginProfileId:
          description: |-
            **string**
            Required field.
            The maximum string length in characters is 50.
          type: string
      required:
        - osLoginProfileId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/getProfile.md
---

# Identity Hub API, REST: OsLogin.GetProfile

OsLogin Profiles

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/osLoginProfiles/{osLoginProfileId}
```

## Path parameters

#|
||Field | Description ||
|| osLoginProfileId | **string**

Required field.

The maximum string length in characters is 50. ||
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