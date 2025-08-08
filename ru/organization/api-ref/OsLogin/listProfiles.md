---
editable: false
apiPlayground:
  - url: https://organization-manager.{{ api-host }}/organization-manager/v1/osLoginProfiles
    method: get
    path: null
    query:
      type: object
      properties:
        organizationId:
          description: |-
            **string**
            Required field. 
          type: string
        pageSize:
          description: '**string** (int64)'
          type: string
          format: int64
        pageToken:
          description: '**string**'
          type: string
        filter:
          description: |-
            **string**
            A filter expression that filters profiles listed in the response.
            The expression must specify:
            1. The field name. Currently you can use filtering by subject_id, uid or login.
            2. An `=` operator.
            3. The value in double quotes (`"`).
            E.g. login="example-login"
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
sourcePath: en/_api-ref/organizationmanager/v1/api-ref/OsLogin/listProfiles.md
---

# Identity Hub API, REST: OsLogin.ListProfiles

## HTTP request

```
GET https://organization-manager.{{ api-host }}/organization-manager/v1/osLoginProfiles
```

## Query parameters {#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesRequest}

#|
||Field | Description ||
|| organizationId | **string**

Required field.  ||
|| pageSize | **string** (int64) ||
|| pageToken | **string** ||
|| filter | **string**

A filter expression that filters profiles listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering by subject_id, uid or login.
2. An `=` operator.
3. The value in double quotes (`"`).
E.g. login="example-login" ||
|#

## Response {#yandex.cloud.organizationmanager.v1.ListOsLoginProfilesResponse}

**HTTP Code: 200 - OK**

```json
{
  "profiles": [
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
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| profiles[] | **[OsLoginProfile](#yandex.cloud.organizationmanager.v1.OsLoginProfile)** ||
|| nextPageToken | **string** ||
|#

## OsLoginProfile {#yandex.cloud.organizationmanager.v1.OsLoginProfile}

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