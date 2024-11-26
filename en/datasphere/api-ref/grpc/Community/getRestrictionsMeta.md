---
editable: false
sourcePath: en/_api-ref-grpc/datasphere/v2/api-ref/grpc/Community/getRestrictionsMeta.md
---

# DataSphere API v2, gRPC: CommunityService.GetRestrictionsMeta

Get meta information about available restrictions.

## gRPC request

**rpc GetRestrictionsMeta ([google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)) returns ([GetRestrictionsMetaResponse](#yandex.cloud.datasphere.v2.GetRestrictionsMetaResponse))**

## google.protobuf.Empty {#google.protobuf.Empty}

```json
{}
```

#|
||Field | Description ||
|| Empty | > ||
|#

## GetRestrictionsMetaResponse {#yandex.cloud.datasphere.v2.GetRestrictionsMetaResponse}

```json
{
  "restrictions_meta": [
    {
      "name": "string",
      "value_type": "RestrictionValueType"
    }
  ]
}
```

#|
||Field | Description ||
|| restrictions_meta[] | **[RestrictionMeta](#yandex.cloud.datasphere.v2.RestrictionMeta)**

List of restrictions. ||
|#

## RestrictionMeta {#yandex.cloud.datasphere.v2.RestrictionMeta}

#|
||Field | Description ||
|| name | **string**

Name of restriction. ||
|| value_type | enum **RestrictionValueType**

Value type of restriction.

- `RESTRICTION_VALUE_TYPE_UNSPECIFIED`
- `BOOLEAN`
- `LONG`
- `STRING` ||
|#