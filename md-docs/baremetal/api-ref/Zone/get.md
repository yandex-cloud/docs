[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > [REST (англ.)](../index.md) > [Zone](index.md) > Get

# BareMetal API, REST: Zone.Get

Returns the specific Zone resource.
To get the list of Zone resources, make a [List](list.md#List) request.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/zones/{zoneId}
```

## Path parameters

#|
||Field | Description ||
|| zoneId | **string**

Required field. ID of the Zone resource to return.
To get the zone ID, use a [ZoneService.List](list.md#List) request.

The maximum string length in characters is 20. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.Zone}

**HTTP Code: 200 - OK**

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