---
editable: false
sourcePath: en/_api-ref/compute/v1/api-ref/Zone/list.md
---

# Compute Cloud API, REST: Zone.List {#List}

Retrieves the list of availability zones.

## HTTP request

```
GET https://compute.{{ api-host }}/compute/v1/zones
```

## Query parameters {#yandex.cloud.compute.v1.ListZonesRequest}

#|
||Field | Description ||
|| pageSize | **string** (int64)

The maximum number of results per page to return. If the number of available
results is larger than `pageSize`,
the service returns a [ListZonesResponse.nextPageToken](#yandex.cloud.compute.v1.ListZonesResponse)
that can be used to get the next page of results in subsequent list requests. ||
|| pageToken | **string**

Page token. To get the next page of results, set `pageToken` to the
[ListZonesResponse.nextPageToken](#yandex.cloud.compute.v1.ListZonesResponse) returned by a previous list request. ||
|#

## Response {#yandex.cloud.compute.v1.ListZonesResponse}

**HTTP Code: 200 - OK**

```json
{
  "zones": [
    {
      "id": "string",
      "regionId": "string",
      "status": "string"
    }
  ],
  "nextPageToken": "string"
}
```

#|
||Field | Description ||
|| zones[] | **[Zone](#yandex.cloud.compute.v1.Zone)**

List of availability zones. ||
|| nextPageToken | **string**

This token allows you to get the next page of results for list requests. If the number of results
is larger than [ListZonesRequest.pageSize](#yandex.cloud.compute.v1.ListZonesRequest), use
the [ListZonesRequest.pageToken](#yandex.cloud.compute.v1.ListZonesRequest) as the value
for the [ListZonesRequest.pageToken](#yandex.cloud.compute.v1.ListZonesRequest) query parameter
in the next list request. Subsequent list requests will have their own
[ListZonesRequest.pageToken](#yandex.cloud.compute.v1.ListZonesRequest) to continue paging through the results. ||
|#

## Zone {#yandex.cloud.compute.v1.Zone}

Availability zone. For more information, see [Availability zones](/docs/overview/concepts/geo-scope).

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|| regionId | **string**

ID of the region. ||
|| status | **enum** (Status)

Status of the zone.

- `STATUS_UNSPECIFIED`
- `UP`: Zone is available. You can access the resources allocated in this zone.
- `DOWN`: Zone is not available. ||
|#