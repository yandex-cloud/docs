---
editable: false
---

# BareMetal API, gRPC: ZoneService.GetZone


Returns the specific Zone resource.

To get the list of Zone resources, make a [List] request.

## gRPC request

**rpc GetZone ([GetZoneRequest](#yandex.cloud.baremetal.v2.GetZoneRequest)) returns ([Zone](#yandex.cloud.baremetal.v2.Zone))**

## GetZoneRequest {#yandex.cloud.baremetal.v2.GetZoneRequest}

```json
{
  "zone_id": "string"
}
```

#|
||Field | Description ||
|| zone_id | **string**

ID of the Zone resource to return.

To get the zone ID, use a [ZoneService.List] request.

The maximum string length in characters is 20. ||
|#

## Zone {#yandex.cloud.baremetal.v2.Zone}

```json
{
  "zone_id": "string"
}
```

Availability zone.

#|
||Field | Description ||
|| zone_id | **string**

ID of the Zone. ||
|#