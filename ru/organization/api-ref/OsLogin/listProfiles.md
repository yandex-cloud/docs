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
            The maximum string length in characters is 50.
          type: string
        pageSize:
          description: |-
            **string** (int64)
            Acceptable values are 0 to 1000, inclusive.
          type: string
          format: int64
        pageToken:
          description: |-
            **string**
            The maximum string length in characters is 2000.
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
            The maximum string length in characters is 1000.
          type: string
      required:
        - organizationId
      additionalProperties: false
    body: null
    definitions: null
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

Required field.

The maximum string length in characters is 50. ||
|| pageSize | **string** (int64)

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

The maximum string length in characters is 2000. ||
|| filter | **string**

A filter expression that filters profiles listed in the response.
The expression must specify:
1. The field name. Currently you can use filtering by subject_id, uid or login.
2. An `=` operator.
3. The value in double quotes (`"`).
E.g. login="example-login"

The maximum string length in characters is 1000. ||
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