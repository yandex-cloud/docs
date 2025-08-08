---
editable: false
apiPlayground:
  - url: https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:restrictions
    method: get
    path:
      type: object
      properties:
        projectId:
          description: |-
            **string**
            Required field. ID of the project.
          type: string
      required:
        - projectId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/datasphere/v2/api-ref/Project/getRestrictions.md
---

# DataSphere API v2, REST: Project.GetRestrictions

Get current project restrictions.

## HTTP request

```
GET https://datasphere.{{ api-host }}/datasphere/v2/projects/{projectId}:restrictions
```

## Path parameters

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the project. ||
|#

## Response {#yandex.cloud.datasphere.v2.RestrictionsResponse}

**HTTP Code: 200 - OK**

```json
{
  "restrictions": [
    {
      "name": "string",
      "boolValue": [
        "boolean"
      ],
      "longValue": [
        "string"
      ],
      "stringValue": [
        "string"
      ]
    }
  ]
}
```

#|
||Field | Description ||
|| restrictions[] | **[Restriction](#yandex.cloud.datasphere.v2.Restriction)**

List of restrictions. ||
|#

## Restriction {#yandex.cloud.datasphere.v2.Restriction}

#|
||Field | Description ||
|| name | **string**

Name of restriction. ||
|| boolValue[] | **boolean**

List of boolean restriction values. Empty if value type is not boolean. ||
|| longValue[] | **string** (int64)

List of long restriction values. Empty if value type is not long. ||
|| stringValue[] | **string**

List of string restriction values. Empty if value type is not string. ||
|#