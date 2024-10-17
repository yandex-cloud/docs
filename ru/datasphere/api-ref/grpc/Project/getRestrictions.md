---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Project/getRestrictions.md
---

# DataSphere API v2, gRPC: ProjectService.GetRestrictions {#GetRestrictions}

Get current project restrictions.

## gRPC request

**rpc GetRestrictions ([GetProjectRestrictionsRequest](#yandex.cloud.datasphere.v2.GetProjectRestrictionsRequest)) returns ([RestrictionsResponse](#yandex.cloud.datasphere.v2.RestrictionsResponse))**

## GetProjectRestrictionsRequest {#yandex.cloud.datasphere.v2.GetProjectRestrictionsRequest}

```json
{
  "projectId": "string"
}
```

#|
||Field | Description ||
|| projectId | **string**

Required field. ID of the project. ||
|#

## RestrictionsResponse {#yandex.cloud.datasphere.v2.RestrictionsResponse}

```json
{
  "restrictions": [
    {
      "name": "string",
      "boolValue": [
        "bool"
      ],
      "longValue": [
        "int64"
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
|| boolValue[] | **bool**

List of boolean restriction values. Empty if value type is not boolean. ||
|| longValue[] | **int64**

List of long restriction values. Empty if value type is not long. ||
|| stringValue[] | **string**

List of string restriction values. Empty if value type is not string. ||
|#