---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Community/getRestrictions.md
---

# DataSphere API v2, gRPC: CommunityService.GetRestrictions {#GetRestrictions}

Get current community restrictions.

## gRPC request

**rpc GetRestrictions ([GetCommunityRestrictionsRequest](#yandex.cloud.datasphere.v2.GetCommunityRestrictionsRequest)) returns ([RestrictionsResponse](#yandex.cloud.datasphere.v2.RestrictionsResponse))**

## GetCommunityRestrictionsRequest {#yandex.cloud.datasphere.v2.GetCommunityRestrictionsRequest}

```json
{
  "communityId": "string"
}
```

#|
||Field | Description ||
|| communityId | **string**

Required field. ID of the community. ||
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