---
editable: false
sourcePath: en/_api-ref/quotamanager/v1/api-ref/QuotaLimit/list.md
---

# Quota Manager API, REST: QuotaLimit.List

Retrieves the list of quota limits for a given service.

## HTTP request

```
GET https://quota-manager.{{ api-host }}/quota-manager/v1/quotaLimits
```

## Query parameters {#yandex.cloud.quotamanager.v1.ListQuotaLimitsRequest}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)**

Required field. The resource for which quota limits are being listed. ||
|| service | **string**

Required field. The service for which quota limits are being requested. ||
|| pageSize | **string** (int64)

The maximum number of quota limits to return per response. ||
|| pageToken | **string**

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

## Response {#yandex.cloud.quotamanager.v1.ListQuotaLimitsResponse}

**HTTP Code: 200 - OK**

```json
{
  "resource": {
    "id": "string",
    "type": "string"
  },
  "quotaLimits": [
    {
      "quotaId": "string",
      "limit": "number",
      "usage": "number"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource2)**

The associated resource for these quota limits. ||
|| quotaLimits[] | **[QuotaLimit](#yandex.cloud.quotamanager.v1.QuotaLimit)**

List of quota limits for the specified resource and service. ||
|| nextPageToken | **string**

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
|| quotaId | **string**

The unique id of the quota. ||
|| limit | **number** (double)

The limit value set for this quota. ||
|| usage | **number** (double)

The current usage level of this quota. ||
|#