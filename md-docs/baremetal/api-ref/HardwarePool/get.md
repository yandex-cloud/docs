[Документация Yandex Cloud](../../../index.md) > [Yandex BareMetal](../../index.md) > Концепции > Настройка и управление > Справочник API > [REST (англ.)](../index.md) > [HardwarePool](index.md) > Get

# BareMetal API, REST: HardwarePool.Get

Returns the specific HardwarePool resource.
To get the list of available HardwarePool resource, make a [List](list.md#List) request.

## HTTP request

```
GET https://baremetal.api.cloud.yandex.net/baremetal/v1alpha/hardwarePools/{hardwarePoolId}
```

## Path parameters

#|
||Field | Description ||
|| hardwarePoolId | **string**

Required field. ID of the HardwarePool resource to return.
To get the hardware pool ID, use a [HardwarePoolService.List](list.md#List) request.

The maximum string length in characters is 20. ||
|#

## Response {#yandex.cloud.baremetal.v1alpha.HardwarePool}

**HTTP Code: 200 - OK**

```json
{
  "id": "string",
  "zoneId": "string"
}
```

A HardwarePool resource.

#|
||Field | Description ||
|| id | **string**

ID of the hardware pool. ||
|| zoneId | **string**

ID of the zone where the hardware pool is located.
To get the zone ID use a [ZoneService.List](../Zone/list.md#List) request. ||
|#