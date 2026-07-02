[Документация Yandex Cloud](../../../../index.md) > [Yandex BareMetal](../../../index.md) > Концепции > Настройка и управление > Справочник API > [gRPC (англ.)](../index.md) > [HardwarePool](index.md) > Get

# BareMetal API, gRPC: HardwarePoolService.Get

Returns the specific HardwarePool resource.
To get the list of available HardwarePool resource, make a [List](list.md#List) request.

## gRPC request

**rpc Get ([GetHardwarePoolRequest](#yandex.cloud.baremetal.v1alpha.GetHardwarePoolRequest)) returns ([HardwarePool](#yandex.cloud.baremetal.v1alpha.HardwarePool))**

## GetHardwarePoolRequest {#yandex.cloud.baremetal.v1alpha.GetHardwarePoolRequest}

```json
{
  "hardware_pool_id": "string"
}
```

#|
||Field | Description ||
|| hardware_pool_id | **string**

ID of the HardwarePool resource to return.
To get the hardware pool ID, use a [HardwarePoolService.List](list.md#List) request.

The maximum string length in characters is 20. ||
|#

## HardwarePool {#yandex.cloud.baremetal.v1alpha.HardwarePool}

```json
{
  "id": "string",
  "zone_id": "string"
}
```

A HardwarePool resource.

#|
||Field | Description ||
|| id | **string**

ID of the hardware pool. ||
|| zone_id | **string**

ID of the zone where the hardware pool is located.
To get the zone ID use a [ZoneService.List](../Zone/list.md#List) request. ||
|#