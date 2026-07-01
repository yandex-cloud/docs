# Quota Manager API, REST: QuotaLimit.ListServices

Retrieves the list of services available for quota management.

## HTTP request

```
GET https://quota-manager.api.cloud.yandex.net/quota-manager/v1/quotaLimits/services
```

## Query parameters {#yandex.cloud.quotamanager.v1.ListServicesRequest}

#|
||Field | Description ||
|| resourceType | **string**

Required field. The type of resources for which services are being requested.

The maximum string length in characters is 64. ||
|| pageSize | **string** (int64)

The maximum number of services to return per response.

Acceptable values are 0 to 1000, inclusive. ||
|| pageToken | **string**

Token to retrieve the next page of results. Omitted on the first request.

The maximum string length in characters is 2000. ||
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
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| services[] | **[Service](#yandex.cloud.quotamanager.v1.Service)**

List of services available for quota management. ||
|| nextPageToken | **string**

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