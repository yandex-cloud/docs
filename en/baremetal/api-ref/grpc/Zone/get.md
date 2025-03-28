---
editable: false
sourcePath: en/_api-ref-grpc/baremetal/v1alpha/api-ref/grpc/Zone/get.md
---

# BareMetal API, gRPC: ZoneService.Get

Returns the specific Zone resource.

To get the list of Zone resources, make a [List](/docs/baremetal/api-ref/grpc/Zone/list#List) request.

## gRPC request

**rpc Get ([GetZoneRequest](#yandex.cloud.baremetal.v1alpha.GetZoneRequest)) returns ([Zone](#yandex.cloud.baremetal.v1alpha.Zone))**

## GetZoneRequest {#yandex.cloud.baremetal.v1alpha.GetZoneRequest}

```json
{
  "zone_id": "string"
}
```

#|
||Field | Description ||
|| zone_id | **string**

ID of the Zone resource to return.

To get the zone ID, use a [ZoneService.List](/docs/baremetal/api-ref/grpc/Zone/list#List) request. ||
|#

## Zone {#yandex.cloud.baremetal.v1alpha.Zone}

```json
{
  "id": "string"
}
```

Availability zone.

#|
||Field | Description ||
|| id | **string**

ID of the zone. ||
|#