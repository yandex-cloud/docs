---
editable: false
sourcePath: en/_api-ref-grpc/quotamanager/v1/api-ref/grpc/QuotaLimit/list.md
---

# Quota Manager API, gRPC: QuotaLimitService.List

Retrieves the list of quota limits for a given service.

## gRPC request

**rpc List ([ListQuotaLimitsRequest](#yandex.cloud.quotamanager.v1.ListQuotaLimitsRequest)) returns ([ListQuotaLimitsResponse](#yandex.cloud.quotamanager.v1.ListQuotaLimitsResponse))**

## ListQuotaLimitsRequest {#yandex.cloud.quotamanager.v1.ListQuotaLimitsRequest}

```json
{
  "resource": {
    "id": "string",
    "type": "string"
  },
  "service": "string",
  "page_size": "int64",
  "page_token": "string"
}
```

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)**

Required field. The resource for which quota limits are being listed. ||
|| service | **string**

Required field. The service for which quota limits are being requested. ||
|| page_size | **int64**

The maximum number of quota limits to return per response. ||
|| page_token | **string**

Token to retrieve the next page of results. Omitted on the first request. ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## ListQuotaLimitsResponse {#yandex.cloud.quotamanager.v1.ListQuotaLimitsResponse}

```json
{
  "resource": {
    "id": "string",
    "type": "string"
  },
  "quota_limits": [
    {
      "quota_id": "string",
      "limit": "google.protobuf.DoubleValue",
      "usage": "google.protobuf.DoubleValue"
    }
  ],
  "next_page_token": "string"
}
```

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource2)**

The associated resource for these quota limits. ||
|| quota_limits[] | **[QuotaLimit](#yandex.cloud.quotamanager.v1.QuotaLimit)**

List of quota limits for the specified resource and service. ||
|| next_page_token | **string**

Token to retrieve the next page of results. ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource2}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## QuotaLimit {#yandex.cloud.quotamanager.v1.QuotaLimit}

#|
||Field | Description ||
|| quota_id | **string**

The unique id of the quota. ||
|| limit | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The limit value set for this quota. ||
|| usage | **[google.protobuf.DoubleValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/double-value)**

The current usage level of this quota. ||
|#