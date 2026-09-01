[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > API v2 > [REST (англ.)](../index.md) > [Zone](index.md) > GetZone

# BareMetal API, REST: Zone.GetZone


Returns the specific Zone resource.

To get the list of Zone resources, make a [List] request.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v2/zones/{zoneId}
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the Zone resource to return.

To get the zone ID, use a [ZoneService.List] request.

The maximum string length in characters is 20. ||
|#

## Response {#yandex.cloud.baremetal.v2.Zone}

**HTTP Code: 200 - OK**

```json
{
  "zoneId": "string"
}
```

Availability zone.

#|
||Field | Description ||
|| zoneId | **string**

ID of the Zone. ||
|#