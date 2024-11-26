---
editable: false
sourcePath: en/_api-ref-grpc/compute/v1/api-ref/grpc/Zone/get.md
---

# Compute Cloud API, gRPC: ZoneService.Get

Returns the information about the specified availability zone.

To get the list of availability zones, make a [List](/docs/compute/api-ref/grpc/Zone/list#List) request.

## gRPC request

**rpc Get ([GetZoneRequest](#yandex.cloud.compute.v1.GetZoneRequest)) returns ([Zone](#yandex.cloud.compute.v1.Zone))**

## GetZoneRequest {#yandex.cloud.compute.v1.GetZoneRequest}

```json
{
  "zone_id": "string"
}
```

#|
||Field | Description ||
|| zone_id | **string**

Required field. ID of the availability zone to return information about. ||
|#

## Zone {#yandex.cloud.compute.v1.Zone}

```json
{
  "id": "string",
  "region_id": "string",
  "status": "Status"
}
```

Availability zone. For more information, see [Availability zones](/docs/overview/concepts/geo-scope).

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|| region_id | **string**

ID of the region. ||
|| status | enum **Status**

Status of the zone.

- `STATUS_UNSPECIFIED`
- `UP`: Zone is available. You can access the resources allocated in this zone.
- `DOWN`: Zone is not available. ||
|#