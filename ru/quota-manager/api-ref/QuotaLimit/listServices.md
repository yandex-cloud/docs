---
editable: false
sourcePath: en/_api-ref/quotamanager/v1/api-ref/QuotaLimit/listServices.md
---

# Quota Manager API, REST: QuotaLimit.ListServices

Retrieves the list of services available for quota management.

## HTTP request

```
GET https://quota-manager.{{ api-host }}/quota-manager/v1/quotaLimits/services
```

## Query parameters {#yandex.cloud.quotamanager.v1.ListServicesRequest}

#|
||Field | Description ||
|| resourceType | **string**

Required field. The type of resources for which services are being requested. ||
|| pageSize | **string** (int64)

The maximum number of services to return per response. ||
|| pageToken | **string**

Token to retrieve the next page of results. Omitted on the first request. ||
|#

## Response {#yandex.cloud.quotamanager.v1.ListServicesResponse}

**HTTP Code: 200 - OK**

```json
{
  "services": [
    {
      "id": "string",
      "name": "string"
    }
  ],
  "pageToken": "string"
}
```

#|
||Field | Description ||
|| services[] | **[Service](#yandex.cloud.quotamanager.v1.Service)**

List of services available for quota management. ||
|| pageToken | **string**

Token to retrieve the next page of results. ||
|#

## Service {#yandex.cloud.quotamanager.v1.Service}

#|
||Field | Description ||
|| id | **string**

The unique id of the service. ||
|| name | **string**

The name of the service. ||
|#