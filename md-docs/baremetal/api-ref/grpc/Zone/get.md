[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [Zone](index.md) > Get

# BareMetal API, gRPC: ZoneService.Get

Returns the specific Zone resource.
To get the list of Zone resources, make a [List](list.md#List) request.

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
To get the zone ID, use a [ZoneService.List](list.md#List) request.

The maximum string length in characters is 20. ||
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