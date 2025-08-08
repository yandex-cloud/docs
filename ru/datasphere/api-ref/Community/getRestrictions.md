---
editable: false
apiPlayground:
  - url: https://datasphere.{{ api-host }}/datasphere/v2/communities/{communityId}:restrictions
    method: get
    path:
      type: object
      properties:
        communityId:
          description: |-
            **string**
            Required field. ID of the community.
          type: string
      required:
        - communityId
      additionalProperties: false
    query: null
    body: null
    definitions: null
sourcePath: en/_api-ref/datasphere/v2/api-ref/Community/getRestrictions.md
---

# DataSphere API v2, REST: Community.GetRestrictions

Get current community restrictions.

## HTTP request

```
GET https://datasphere.{{ api-host }}/datasphere/v2/communities/{communityId}:restrictions
```

## Path parameters

#|
||Field | Description ||
|| communityId | **string**

Required field. ID of the community. ||
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