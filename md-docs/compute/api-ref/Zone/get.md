# Compute Cloud API, REST: Zone.Get

Returns the information about the specified availability zone.
To get the list of availability zones, make a [List](list.md#List) request.

## HTTP request

```
GET https://compute.api.cloud.yandex.net/compute/v1/zones/{zoneId}
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the availability zone to return information about.
The length must be less than or equal to 50.
This field is required. ||
|#

## Response {#yandex.cloud.compute.v1.Zone}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "regionId": "string",
  "status": "string"
}
```

Availability zone. For more information, see [Availability zones](../../../overview/concepts/geo-scope.md).

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|| regionId | **string**

ID of the region. ||
|| status | **enum** (Status)

Status of the zone.

- `UP`: Zone is available. You can access the resources allocated in this zone.
- `DOWN`: Zone is not available. ||
|#