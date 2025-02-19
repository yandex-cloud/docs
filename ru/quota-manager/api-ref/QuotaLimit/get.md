---
editable: false
sourcePath: en/_api-ref/quotamanager/v1/api-ref/QuotaLimit/get.md
---

# Quota Manager API, REST: QuotaLimit.Get

Returns the specified quota limit.

## HTTP request

```
GET https://quota-manager.{{ api-host }}/quota-manager/v1/quotaLimits/{quotaId}
```

## Path parameters

#|
||Field | Description ||
|| quotaId | **string**

Required field. The id of the quota to retrieve. ||
|#

## Query parameters {#yandex.cloud.quotamanager.v1.GetQuotaLimitRequest}

#|
||Field | Description ||
|| resource | **[Resource](#yandex.cloud.quotamanager.v1.Resource)**

Required field. The resource for which the quota limit is being requested. ||
|#

## Resource {#yandex.cloud.quotamanager.v1.Resource}

#|
||Field | Description ||
|| id | **string**

Required field. The id if the resource. ||
|| type | **string**

Required field. The type of the resource, e.g. resource-manager.cloud, billing.account. ||
|#

## Response {#yandex.cloud.quotamanager.v1.QuotaLimit}

**HTTP Code: 200 - OK**

```json
{
  "quotaId": "string",
  "limit": "number",
  "usage": "number"
}
```

#|
||Field | Description ||
|| quotaId | **string**

The unique id of the quota. ||
|| limit | **number** (double)

The limit value set for this quota. ||
|| usage | **number** (double)

The current usage level of this quota. ||
|#