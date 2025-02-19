---
editable: false
sourcePath: en/_api-ref-grpc/quotamanager/v1/api-ref/grpc/QuotaLimit/get.md
---

# Quota Manager API, gRPC: QuotaLimitService.Get

Returns the specified quota limit.

## gRPC request

**rpc Get ([GetQuotaLimitRequest](#yandex.cloud.quotamanager.v1.GetQuotaLimitRequest)) returns ([QuotaLimit](#yandex.cloud.quotamanager.v1.QuotaLimit))**

## GetQuotaLimitRequest {#yandex.cloud.quotamanager.v1.GetQuotaLimitRequest}

```json
{
  "resource": {
    "id": "string",
    "type": "string"
  },
  "quota_id": "string"
}
```

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)**

Required field. The resource for which the quota limit is being requested. ||
|| quota_id | **string**

Required field. The id of the quota to retrieve. ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## QuotaLimit {#yandex.cloud.quotamanager.v1.QuotaLimit}

```json
{
  "quota_id": "string",
  "limit": "google.protobuf.DoubleValue",
  "usage": "google.protobuf.DoubleValue"
}
```

#|
||Field | Description ||
|| quota_id | **string**

The unique id of the quota. ||
|| limit | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The limit value set for this quota. ||
|| usage | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The current usage level of this quota. ||
|#